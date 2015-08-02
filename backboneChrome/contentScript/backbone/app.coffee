app = {}

app.DictionaryView = Backbone.View.extend
  tagName: "div"
  className: "ext-dictionary"
  # template:
  # $el:

  initialize: (data) ->
    @.template = _.template $("#ext-dictionary-t").html()
    @.$el.html @.template({data: data})
    @.styling()

  styling: ->
    @.$('[data-toggle="popover"]').each ->
      $popoverContent = $(this).next().clone()
      $popoverContent.find("a").click -> alert "fudge"
      $(this).popover({content: $popoverContent})
      $(this).next().remove()

app.AppView = Backbone.View.extend
  el: "#ext-content"
  # $dictionaries:

  sampleUrls: [
    chrome.extension.getURL("contentScript/backbone/dictionary0.json")
    chrome.extension.getURL("contentScript/backbone/dictionary1.json")
  ]
  
  initialize: ->
    @.$dictionaries = @.$("#ext-dictionaries")
    @.render()

  render: ->
    _.each @.sampleUrls, (url) =>
      $.getJSON url, (data) =>
        dictionaryView = new app.DictionaryView(data)
        @.$dictionaries.append dictionaryView.$el
        @.$('[data-toggle="popover"]').popover();
        

root = exports ? @
root.extBackboneApp = app
