app = {}

app.DictionaryView = Backbone.View.extend
  tagName: "div"
  className: "ext-dictionary panel"

  initialize: (data) ->
    @.template = _.template $("#ext-dictionary-t").html()
    @.$el.html @.template({data: data})
    @.initPopover()

  events:
    "click .suggestion": (e) ->
      app.appView.$inputWord.val $(e.currentTarget).text()
      app.appView.searchWord()

  initPopover: ->
    $popovers = @.$('[data-toggle="popover"]')
    $popovers.each ->
      $popoverContent = $(this).next().clone()
      $popoverContent.find(".meaning").click ->
        app.appView.$inputMeaning.val $(this).text()

      $(this).popover({content: $popoverContent})
      $(this).next().remove()

    $popovers.mouseover( ->
      $(this).popover 'show'
      
    ).on 'show.bs.popover', ->
      $popovers.not($(this)).popover 'hide'


    @.$el.mouseleave ->
      $popovers.popover 'hide'


app.AppView = Backbone.View.extend

  initialize: ->
    @.$dictionaries  = @.$("#ext-dictionaries")
    @.$inputWord     = @.$("#ext-word")   # these are the single sources of truth (but, it turned out it's hard to keep this as good source since it's not easy to bind an event to input DOM. Other option seems to be using handlebars?)
    @.$inputSentence = @.$("#ext-sentence")
    @.$inputMeaning  = @.$("#ext-meaning")

  events:
    "keypress #ext-word": (e) -> if e.which is 13 then @.searchWord()

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
        

$.get chrome.extension.getURL("contentScript/contentScript.html"), (data) ->
  app.appView = new app.AppView({el: data})
  $('body').append app.appView.$el


root = exports ? this
root.extBackboneApp = app
