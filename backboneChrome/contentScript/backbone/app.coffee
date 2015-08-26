app = {}

# this model keeps current destination category name, id and validation
# {name: <category-name>, id: <category-id>, status: <ok/wrong>}
# status is always updated at the "sync" event of app.categories collection
app.storage = new MyStorage()

# models and collection
app.Category = Backbone.Model.extend
  parse: (response, options) -> if options.collection then response else response.data
  initialize: -> @on "sync", => app.storage.update @toJSON()

      
app.Categories = Backbone.Collection.extend
  model: app.Category
  url: "http://localhost:4567/categories"
  parse: (response) -> response.data
  initialize: -> @on "sync", =>
    app.storage.get()
    .then (items) =>
      if _.some _(@toJSON()).map((c)-> _(c).isEqual _(items).pick(["name", "id"]))
        app.storage.update {status: "ok"}
      else
        app.storage.update {status: "wrong"}
app.categories = new app.Categories()


# categories view
app.CategoriesView = Backbone.View.extend

  initialize: ->
    @collection = app.categories
    @collection.on "sync", => @render()
    app.storage.on "update", => @render()

    # how often should we check the data with the server (only this time might cause some gaps)
    @collection.fetch()
    app.storage.fetch()

  render: ->
    @template = _.template $("#ext-categories-t").html()
    @$el.html @template({categories: @collection.toJSON()})
    $('.dropdown-toggle').dropdown()
    $("#new-category").popover({content: $("#new-category-popover-content").remove()})
    if app.storage.items.status is "ok"
      @$(".dropdown-title").text app.storage.items.name
      @$("#upload").removeClass("disabled")

  events: ->
    "click .dropdown-menu a": (e) ->
      @collection.fetch()
      app.storage.update $(e.currentTarget).data('category')
    "click #upload": -> app.appView.upload()
    "keypress #new-category-name": "newCategory"

  newCategory: (e) ->
    name = @$("#new-category-name").val()
    if e.which is 13 and name isnt "" then app.categories.create({name: name})
      

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
      app.appView.$inputWord.val $(e.currentTarget).text()
      app.appView.searchWord()

  initPopover: ->
    @$popovers.each ->
      $popoverContent = $(this).next().remove()
      $popoverContent.find(".meaning").click ->
        app.appView.$inputMeaning.val $(this).text()
      $(this).popover {content: $popoverContent}


# main view
app.AppView = Backbone.View.extend

  initialize: ->
    @$el.html _.template($("#ext-content-t").html()) {}
    @$dictionaries  = @$("#ext-dictionaries")
    @$inputWord     = @$("#ext-word")   # these are the single sources of truth (but, it turned out it's hard to keep this as good source since it's not easy to bind an event to input DOM. Other option seems to be using handlebars?)
    @$inputSentence = @$("#ext-sentence")
    @$inputMeaning  = @$("#ext-meaning")

    @renderCategories()

    # take in words and sentences from dblclick
    $('body').dblclick (e) =>
      w = window.getSelection().toString().trim()
      s = window.getSelection().getRangeAt(0).startContainer.parentNode.textContent.trim()
      @$inputWord.val (@$inputWord.val() + " " + w).trim()
      @$inputSentence.val s
      @$inputWord.focus()
      @searchWord()

  renderCategories: ->
    app.categoriesView = new app.CategoriesView el: $("#ext-categories")

  events:
    "keypress #ext-word": (e) -> if e.which is 13 then @searchWord()

  upload: ->
    extLib.tabCapture()
      .catch((err) -> console.log "error - AppView.upload: #{err}")
      .then (dataurl) =>

        data =
          # data url is converted into blob just before sending ajax in eventPage.js adhocly
          picture     : dataurl  
          word        : @$inputWord.val()      
          sentence    : @$inputSentence.val()  
          meaning     : @$inputMeaning.val()   
          category_id : app.storage.items.id

        extLib.ultraAjax(
          url: "http://localhost:4567/upload"
          type: "POST"
          data: data
          processData: false
          contentType: false
        ).catch((err) -> console.log "error: AppView.upload - #{err}")
         .then((data) -> console.log data)


  searchWord: ->
    word = @$inputWord.val().trim()
    if word isnt ""
      @$dictionaries.empty()

      
      if @eijiroView? then @eijiroView.remove()
      @eijiroView = new app.DictionaryView({dictionary: "Eijiro", type: "", loading: true})
      @$dictionaries.append @eijiroView.$el
      extLib.Eijiro(word)
        .catch((err) -> console.log "error in eijiro: #{err}")
        .then (data) => @eijiroView.renderData data
          
        
      if @dAPIView? then @dAPIView.remove()
      @dAPIView = new app.DictionaryView({dictionary: "Merriam-Webster", type: "", loading: true})
      @$dictionaries.append @dAPIView.$el
      extLib.DictionaryAPI(word)
        .catch((err) -> console.log "error in dicAPI: #{err}")
        .then (data) => @dAPIView.renderData data


root = exports ? this
root.app = app
