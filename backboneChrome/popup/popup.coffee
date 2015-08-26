app = {}

app.storage = new MyStorage()

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
          app.mainView.renderFlashMessage "wrong email or password"

    "click #register":   (e) -> extLib.createTab "http://localhost:9000/login"
      

app.authedView = Backbone.View.extend
  initialize: (data) ->
    console.log data
    @$el.html _.template($("#authedView-t").html()) data

  events:
    "click #on":     (e) ->
    "click #off":    (e) ->
    "click #logout": (e) -> app.storage.clear()
      


app.MainView = Backbone.View.extend
  initialize: ->
    $("#flash").hide()
    app.storage.init()
    app.storage.on "update", (data) =>
      console.log "-- app.storage update events --"
      console.log data
      # check if there is a previous session
      if data? and data.session? and data.session.id? and data.session.auth_token?
  
        # check if the stored auth_token is valid
        Promise.resolve(
          $.ajax
            url: "http://localhost:3000/api/users/#{data.session.id}"
            headers: Authorization: data.session.auth_token
  
        ).then (response) =>
           @renderFlashMessage "You are already logged in."
           @renderAuthedView(response.user)
  
         .catch (err) =>
           console.log err
           @renderFlashMessage "Previous session is expired. You need to login again."
           @renderLoginView()
  
      else
        @renderFlashMessage "You need to login."
        @renderLoginView()      

  renderLoginView: ->
    @$el.html new app.loginView().$el

  renderAuthedView: (user) ->
    @$el.html new app.authedView({user: user}).$el

  renderFlashMessage: (message) ->
    $("#flash").text(message).show()

app.mainView = null
    
$ ->
  app.mainView = new app.MainView el: $("#main")
