app = {}

### storage for authentication and destination category ###
app.storage = new MyStorage()

app.User = Backbone.Model.extend
  parse: (response) -> response.user
  urlRoot: "#{myConfig.domain}/api/users"
app.user = new app.User



### keep the destination cateogry of the uploding itme ###
app.Category = Backbone.Model.extend
  parse: (resp, opt) -> if opt.collection then resp else resp.category
app.destination = null
      
app.Categories = Backbone.Collection.extend
  model: app.Category
  url: "#{myConfig.domain}/api/categories"
  parse: (resp) -> resp.categories
app.categories = new app.Categories()



### view for each element of dropdown menu ###
app.CategoryView = Backbone.View.extend
  tagName: "li"
  className: "small"
  initialize: -> @$el.html $("<a>").text @model.get "name"
  events: "click a": -> app.storage.update destination: @model.toJSON()



### dropdown categories view ###
app.CategoriesView = Backbone.View.extend

  initialize: ->
    @template = _.template $("#categoriesDropdown-t").html()
    app.categories.on "sync", => @render()
    app.storage.on "update", (data) => app.destination = data.destination; @render(); @resetContentScriptsApp()
    app.categories.fetch data: user_id: app.storage.getData().session.id
    app.destination = if app.storage.getData().destination then app.storage.getData().destination
    @render()

  render: ->
    @$el.html @template
      title: if app.destination then app.destination.name else "--- Choose Category ---"
    @initDropdown()    
    @initPopover()

  initDropdown: ->
    app.categories.each (category) ->
      @$(".dropdown-menu").append new app.CategoryView({model: category}).$el
    @$('.dropdown-toggle').dropdown()

  initPopover: ->
    @$("#new-category").popover
        content: _.template($("#new-category-popover-content-t").html()) {}
  
  events:
    "keypress #new-category-name": "newCategory"

  newCategory: (e) ->
    name = @$("#new-category-name").val()
    if e.which is 13 and name isnt ""
      newCat = app.categories.create {name: name},
                 headers: Authorization: app.storage.getData().session.auth_token
      # to reduce the data to store not putting model itself
      app.storage.update destination: newCat.toJSON()

  resetContentScriptsApp: ->
    chrome.tabs.query {active: true, currentWindow: true}, (tabs) ->
      chrome.tabs.sendMessage tabs[0].id, type: "popup#appReset"



### after authentication ###
app.AuthedView = Backbone.View.extend
  initialize: ->
    @$el.html _.template($("#authedView-t").html()) {user: @model.toJSON()}
    app.categoriesView = new app.CategoriesView el: @$("#categoriesDropdown")

  events:
    "click #on":     (e) ->
       chrome.tabs.query {active: true, currentWindow: true}, (tabs) ->
         chrome.tabs.sendMessage tabs[0].id, type: "popup#appOn"    

    "click #off":    (e) ->
       chrome.tabs.query {active: true, currentWindow: true}, (tabs) ->
         chrome.tabs.sendMessage tabs[0].id, type: "popup#appOff"    

    "click #logout": (e) -> app.storage.clear()



### before authentication ###
app.LoginView = Backbone.View.extend
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
          url: "#{myConfig.domain}/api/sessions"
          type: "POST"
          data: @$("#loginForm").serialize()
  
      ).then (data) =>
          app.storage.update {session: data}
          
       .catch (err)  =>
          app.mainView.renderFlashMessage "Error happend. Try again."

    "click #register":   (e) -> extLib.createTab "#{myConfig.domain}/login"
      


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
      $("#flash").hide()
      @renderAuthedView app.user
      
    app.user.on "error", =>
      @renderFlashMessage "Error happened. Try to login again."
      @renderLoginView()


  renderLoginView: ->
    @$el.html new app.LoginView().$el

  renderAuthedView: (user) ->
    @$el.html new app.AuthedView({model: user}).$el

  renderFlashMessage: (message) ->
    $("#flash").text(message).show()


app.mainView = null
$ ->
  app.mainView = new app.MainView el: $("#main")
