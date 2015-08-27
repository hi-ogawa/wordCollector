app = {}

# popup keeps auth_token into chrome.storage
app.storage = new MyStorage()
app.session = null


# models and collection
app.Category = Backbone.Model.extend
  parse: (resp, opt) -> if opt.collection then resp else resp.category
app.destination = null
      
app.Categories = Backbone.Collection.extend
  model: app.Category
  url: "http://localhost:3000/api/categories"
  parse: (resp) -> resp.categories
app.categories = new app.Categories()


# view for each element of dropdown menu
app.CategoryView = Backbone.View.extend
  tagName: "li"
  initialize: -> @$el.html $("<a>").text @model.get "name"
  events: "click a": -> app.destination = @model; app.categoriesView.render()


# dropdown categories view
app.CategoriesView = Backbone.View.extend

  initialize: ->
    @template = _.template $("#ext-categories-t").html()
    app.categories.on "sync", => @render()
    app.categories.fetch data: user_id: app.session.id

  render: ->
    @$el.html @template
      title: if app.destination then app.destination.get "name" else "--- Choose Category ---"
    @initDropdown()    
    @initPopover()

    @$("#upload").toggleClass("disabled", !app.destination)

    
  initDropdown: ->
    app.categories.each (category) ->
      @$(".dropdown-menu").append new app.CategoryView({model: category}).$el
    @$('.dropdown-toggle').dropdown()

  initPopover: ->
    @$("#new-category").popover
        content: _.template($("#new-category-popover-content-t").html()) {}
  
  events:
    "click #upload": -> app.appView.upload()
    "keypress #new-category-name": "newCategory"

  newCategory: (e) ->
    name = @$("#new-category-name").val()
    if e.which is 13 and name isnt ""
      app.destination = app.categories.create {name: name},
                          headers: Authorization: app.session.auth_token
      @render()


# dictionary view
app.DictionaryView = Backbone.View.extend
  tagName: "div"

  initialize: (data) ->
    @template = _.template $("#ext-dictionary-t").html()
    @$el.html @template({data: data})

  renderData: (data) ->
    @$el.html @template({data: data})
    finalHeight = @$el.height()
    @$el.css("height", "20px")
    @$el.animate {"height": finalHeight}, "slow"
    @$popovers = @$('[data-toggle="popover"]')
    @initPopover()

  events:
    "click .remove": "remove"

    # popovers behaviour
    "mouseleave": -> @$popovers.popover 'hide'

    "mouseover [data-toggle='popover']": (e) ->
      $(e.currentTarget).popover 'show'

    "show.bs.popover [data-toggle='popover']": (e) ->
      @$popovers.not($(e.currentTarget)).popover 'hide'

    "click .suggestion": (e) ->
      app.appView.$("#ext-word").val $(e.currentTarget).text()
      app.appView.renderDictionaries()

  initPopover: ->
    @$popovers.each ->
      $popoverContent = $(this).next().remove()
      $popoverContent.find(".meaning").click ->
        app.appView.$("#ext-meaning").val $(this).text()
      $(this).popover {content: $popoverContent}


# main view
app.AppView = Backbone.View.extend

  initialize: ->
    @$el.html _.template($("#ext-content-t").html()) {}

    app.storage.init()
    app.storage.on "update", (data) =>
      app.session = data.session
      @renderCategories()  

    # take in words and sentences from dblclick
    $('body').dblclick (e) =>
      w = window.getSelection().toString().trim()
      s = window.getSelection().getRangeAt(0).startContainer.parentNode.textContent.trim()
      @$("#ext-word").val (@$("#ext-word").val() + " " + w).trim()
                     .focus()
      @$("#ext-sentence").val s
      @renderDictionaries()

  events:
    "keypress #ext-word": (e) -> if e.which is 13 then @renderDictionaries()

  renderCategories: ->
    app.categoriesView = new app.CategoriesView el: $("#ext-categories")

  renderDictionaries: ->
    word = @$("#ext-word").val().trim()
    if word isnt ""
      @renderEijiro  word
      @renderMarriam word

  renderEijiro: (word) ->
    if @eijiroView? then @eijiroView.remove()
    @eijiroView = new app.DictionaryView({dictionary: "Eijiro", type: "", loading: true})
    @$("#ext-dictionaries").append @eijiroView.$el
    extLib.Eijiro(word)
      .catch((err) -> console.log "error in eijiro: #{err}")
      .then (data) => @eijiroView.renderData data
    
  renderMarriam: (word) ->
    if @marriamView? then @marriamView.remove()
    @marriamView = new app.DictionaryView({dictionary: "Merriam-Webster", type: "", loading: true})
    @$("#ext-dictionaries").append @marriamView.$el
    extLib.DictionaryAPI(word)
      .catch((err) -> console.log "error in dicAPI: #{err}")
      .then (data) => @marriamView.renderData data

  upload: ->
    extLib.tabCapture()
      .catch((err) -> console.log "error - AppView.upload: #{err}")
      .then (dataurl) =>

        data =
          category_id: app.destination.id
          item:
            word:     @$("#ext-word").val()
            sentence: @$("#ext-sentence").val()
            meaning:  @$("#ext-meaning").val()
            picture:  extLib.dataURLtoBlob(dataurl)
  
        $.ajax
          url:  "http://localhost:3000/api/items"
          type: "POST"
          data: extLib.json2FormData data
          processData: false
          contentType: false
          headers: Authorization: app.session.auth_token
        .done (resp) -> console.log resp
  
        # data =
        #   # data url is converted into blob just before sending ajax in eventPage.js adhocly
        #   picture     : dataurl  
        #   word        : @$("#ext-word").val()      
        #   sentence    : @$("#ext-sentence").val()  
        #   meaning     : @$("#ext-meaning").val()   
        #   category_id : app.destination.id

        # extLib.ultraAjax(
        #   url: "http://localhost:3000/api/items"
        #   type: "POST"
        #   data: data
        #   processData: false
        #   contentType: false
        # ).catch((err) -> console.log "error: AppView.upload - #{err}")
        #  .then((data) -> console.log data)


root = exports ? this
root.app = app
