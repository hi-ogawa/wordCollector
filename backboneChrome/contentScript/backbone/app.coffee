app = {}

# popup keeps auth_token into chrome.storage
app.storage = new MyStorage()
app.session = null
app.destination = null


# dictionary view
app.DictionaryView = Backbone.View.extend
  tagName: "div"

  initialize: (data) ->
    @template = _.template $("#ext-dictionary-t").html()
    @$el.html @template {data: data}

  renderData: (data) ->
    @$el.html @template {data: data}
    if data.type is "error" then return
    console.log data
    @$popovers = @$('[data-toggle="popover"]')
    @initPopover()
    finalHeight = @$el.height()
    @$el.css("height", "20px")
    @$el.animate {"height": finalHeight}, "slow"

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
    @$('[data-toggle="tooltip"]').tooltip()
    @changeUploadIcons "wait"

    app.storage.init()
    app.storage.on "update", (data) =>
      app.session     = data.session
      app.destination = data.destination

    # take in words and sentences from dblclick
    $('body').dblclick (e) =>
      w = window.getSelection().toString().trim()
      s = window.getSelection().getRangeAt(0).startContainer.parentNode.textContent.trim()
      @$("#ext-word").val (@$("#ext-word").val() + " " + w).trim()
                     .focus()
      @$("#ext-sentence").val s
      @renderDictionaries()

  events:
    "keypress #ext-word": (e) -> if e.which is 13 then e.preventDefault(); @renderDictionaries()
    "submit #upload": (e) -> e.preventDefault(); @upload()

  renderDictionaries: ->
    word = @$("#ext-word").val().trim()
    if word isnt ""
      @renderEijiro  word
      @renderMarriam word

  renderEijiro: (word) ->
    if @eijiroView? then @eijiroView.remove()
    @eijiroView = new app.DictionaryView {dictionary: "Eijiro", type: "", loading: true}
    @$("#ext-dictionaries").append @eijiroView.$el
    extLib.Eijiro(word)
      .then  (data) => @eijiroView.renderData data
      .catch (err)  => @eijiroView.renderData {dictionary: "Eijiro", type: "error", loading: false}
    
  renderMarriam: (word) ->
    if @marriamView? then @marriamView.remove()
    @marriamView = new app.DictionaryView {dictionary: "Merriam-Webster", type: "", loading: true}
    @$("#ext-dictionaries").append @marriamView.$el
    extLib.DictionaryAPI(word)
      .then  (data) => @marriamView.renderData data
      .catch (err)  => @marriamView.renderData {dictionary: "Merriam-Webster", type: "error", loading: false}

  upload: ->
    @changeUploadIcons "loading"
    extLib.tabCapture()
      .then (dataurl) =>

        chrome.runtime.sendMessage
          type: "uploadItem"
          category_id: app.destination.id
          word:     @$("#ext-word").val()
          sentence: @$("#ext-sentence").val()
          meaning:  @$("#ext-meaning").val()
          picture:  dataurl
          headers: Authorization: app.session.auth_token
          , (resp) =>
            if resp.status is "success" then @changeUploadIcons "success"
            else                             @changeUploadIcons "fail"
  
      .catch (err) => @changeUploadIcons "fail"; console.log err

  changeUploadIcons: (state) ->
    @$("#upload-icons > *").each ->
      $(this).toggleClass "hide", !($(this).attr("id").match state)

root = exports ? this
root.app = app
