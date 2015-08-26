app = {}

### storage for authentication ###
app.storage = new MyStorage()

app.User = Backbone.Model.extend
  parse: (response) -> response.user
  urlRoot: "http://localhost:3000/api/users"
app.user = new app.User


### before authentication ###
app.loginView = Backbone.View.extend
  initialize: ->
    @$el.html _.template($("#loginView-t").html()) {}

    ## init input values for easy testing ##
    @$("#loginForm input:eq(0)").val "hiogawa@hiogawa.com"
    @$("#loginForm input:eq(1)").val "12345678"

  events:
    "submit #loginForm": (e) ->
      e.preventDefault()
      Promise.resolve(
        $.ajax
          url: "http://localhost:3000/api/sessions"
          type: "POST"
          data: @$("#loginForm").serialize()
  
      ).then (data) =>
          app.storage.update {session: data}
          
       .catch (err)  =>
          app.mainView.renderFlashMessage "Error happend. Try again."

    "click #register":   (e) -> extLib.createTab "http://localhost:9000/login"
    

      
### after authentication ###
app.authedView = Backbone.View.extend
  initialize: ->
    @$el.html _.template($("#authedView-t").html()) {user: @model.toJSON()}

  events:
    "click #on":     (e) ->
       chrome.tabs.query {active: true, currentWindow: true}, (tabs) ->
         chrome.tabs.sendMessage tabs[0].id, type: "popup#appOn"    

    "click #off":    (e) ->
       chrome.tabs.query {active: true, currentWindow: true}, (tabs) ->
         chrome.tabs.sendMessage tabs[0].id, type: "popup#appOff"    

    "click #logout": (e) -> app.storage.clear()
      


### main view ###
app.MainView = Backbone.View.extend
  initialize: ->
    $("#flash").hide()
    app.storage.init()

    app.storage.on "update", (data) =>
  
      if data? and data.session? and data.session.id? and data.session.auth_token?
        app.user.set   id: data.session.id
                .fetch headers: Authorization: data.session.auth_token
    
      else
        @renderFlashMessage "You need to login."
        @renderLoginView()
  
    app.user.on "sync", =>
      @renderFlashMessage "You are already logged in."
      @renderAuthedView app.user
      
    app.user.on "error", =>
      @renderFlashMessage "Error happened. Try to login again."
      @renderLoginView()


  renderLoginView: ->
    @$el.html new app.loginView().$el

  renderAuthedView: (user) ->
    @$el.html new app.authedView({model: user}).$el

  renderFlashMessage: (message) ->
    $("#flash").text(message).show()

app.mainView = null
    
$ ->
  app.mainView = new app.MainView el: $("#main")
