app = {}

# this model keeps current destination category name and id
# and does some validation here, before uploading
app.LocalData = Backbone.Model.extend
  localStorage: new Backbone.LocalStorage "ext-local-data"
  defaults: {id: 0}
  check: -> # check if the current destination really exists (if not, do something)
    app.localData.get("exists")    

app.localData = new app.LocalData()


# for now, just load data, not create
app.Category = Backbone.Model

app.Categories = Backbone.Collection.extend
  model: app.Category
  url: "http://localhost:4567/categories"
app.categories = new app.Categories()

app.CategoriesView = Backbone.View.extend
  tagName: "div"
  id: "ext-categories"

  initialize: ->
    @.collection = app.categories

    @.collection.on "sync", @.render, @
    app.localData.on "change", @.render, @

    @.collection.fetch()
    app.localData.fetch()

  render: ->
    @.template = _.template $("#ext-categories-t").html()
    @.$el.html @.template({categories: @.collection.toJSON()})
    $('.dropdown-toggle').dropdown()
    $("#new-category").popover({content: $("#new-category-popover-content").remove()})
    if app.localData.check()
      @.$(".dropdown-title").text app.localData.get("name")
      @.$("#upload").removeClass("disabled")

  events: ->
    "click .dropdown-menu a": (e) ->
      app.localData.save
        exists: true
        name: $(e.currentTarget).text()
        categoryId: $(e.currentTarget).attr("data-id")
    "keypress #new-category-name": "newCategory"
    "click #upload": -> if app.localData.check() then app.appView.upload()

  newCategory: (e) ->
    name = @.$("#new-category-name").val()
    if e.which is 13 and name isnt ""
      app.categories.create {name: name}


app.DictionaryView = Backbone.View.extend
  tagName: "div"

  initialize: (data) ->
    @.template = _.template $("#ext-dictionary-t").html()
    @.$el.html @.template({data: data})
    @.$popovers = @.$('[data-toggle="popover"]')
    @.initPopover()

  events:
    "click .remove": "remove"

    # popovers behaviour
    "mouseleave": -> @.$popovers.popover 'hide'

    "mouseover [data-toggle='popover']": (e) ->
      $(e.currentTarget).popover 'show'

    "show.bs.popover [data-toggle='popover']": (e) ->
      @.$popovers.not($(e.currentTarget)).popover 'hide'

    "click .suggestion": (e) ->
      app.appView.$inputWord.val $(e.currentTarget).text()
      app.appView.searchWord()

  initPopover: ->
    @.$popovers.each ->
      $popoverContent = $(this).next().remove()
      $popoverContent.find(".meaning").click ->
        app.appView.$inputMeaning.val $(this).text()
      $(this).popover {content: $popoverContent}


app.AppView = Backbone.View.extend

  initialize: ->
    @.$dictionaries  = @.$("#ext-dictionaries")
    @.$inputWord     = @.$("#ext-word")   # these are the single sources of truth (but, it turned out it's hard to keep this as good source since it's not easy to bind an event to input DOM. Other option seems to be using handlebars?)
    @.$inputSentence = @.$("#ext-sentence")
    @.$inputMeaning  = @.$("#ext-meaning")

    @.renderCategories()

    # take in words and sentences from dblclick
    $('body').dblclick (e) =>
      w = window.getSelection().toString().trim()
      s = window.getSelection().getRangeAt(0).startContainer.parentNode.textContent.trim()
      @.$inputWord.val (@.$inputWord.val() + " " + w).trim()
      @.$inputSentence.val s
      @.$inputWord.focus()
      @.searchWord()

  renderCategories: ->
    app.categoriesView = new app.CategoriesView()
    @.$("#ext-settings").append app.categoriesView.$el

  events:
    "keypress #ext-word": (e) -> if e.which is 13 then @.searchWord()

  upload: ->
    extLib.tabCapture()
      .catch((err) -> console.log "error - AppView.upload: #{err}")
      .then (dataurl) =>

        data =
          # data url is converted into blob just before sending ajax in eventPage.js adhocly
          picture     : dataurl  
          word        : @.$inputWord.val()      
          sentence    : @.$inputSentence.val()  
          meaning     : @.$inputMeaning.val()   
          category_id : app.localData.categoryID

        extLib.ultraAjax(
          url: "http://localhost:4567/upload"
          type: "POST"
          data: data
          processData: false
          contentType: false
        ).catch((err) -> console.log "error: AppView.upload - #{err}")
         .then((data) -> console.log data)


  searchWord: ->
    word = @.$inputWord.val().trim()
    if word isnt ""
      @.$dictionaries.empty()

      extLib.Eijiro(word)
        .catch((err) -> console.log "error in eijiro: #{err}")
        .then (data) =>
          if @.eijiroView? then @.eijiroView.remove()
          @.eijiroView = new app.DictionaryView(data)
          @.$dictionaries.append @.eijiroView.$el
        
      extLib.DictionaryAPI(word)
        .catch((err) -> console.log "error in dicAPI: #{err}")
        .then (data) =>
          if @.dAPIView? then @.dAPIView.remove()
          @.dAPIView = new app.DictionaryView(data)
          @.$dictionaries.append @.dAPIView.$el
        

$.get chrome.extension.getURL("contentScript/contentScript.html"), (html) ->
  $extWrapper = $(html)
  $('body').append $extWrapper
  app.appView = new app.AppView({el: $extWrapper})
  

# root = exports ? this
# root.extBackboneApp = app
