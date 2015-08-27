$.get chrome.extension.getURL("contentScript/contentScript.html"), (html) ->
  $('body').append $(html)

chrome.runtime.onMessage.addListener (request, sender, callback) ->
  switch request.type

    when "popup#appOn"
      unless app.appView
        app.appView = new app.AppView el: $("#ext-content")
  
    when "popup#appOff"
      if app.appView
        app.appView.$el.empty()
        app.appView = null

    when "popup#appReset"
      if app.appView
        app.appView.$el.empty()
        app.appView = new app.AppView el: $("#ext-content")
