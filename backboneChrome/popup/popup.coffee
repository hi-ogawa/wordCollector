# chrome.tabs.query {active: true, currentWindow: true}, (tabs) ->
#   chrome.tabs.sendMessage tabs[0].id,
#           type:     'popup: type'
#           , (responseText) -> console.log responseText

$ ->

  console.log "it's from popup.coffee"

  # https://developer.chrome.com/extensions/content_scripts#pi
  csss = [
    'lib/my_bootstrap_container.css'
    'contentScript/contentScript.css'
  ]
  jss = [
    'lib/jquery.js'
    'lib/bootstrap.js'
    'lib/underscore.js'
    'lib/backbone.js'
    'lib/backbone.localStorage.js'
    'contentScript/backbone/mylib.js'
    'contentScript/backbone/app.js'
    # 'contentScript/contentScript.js'
  ]
  csss.forEach (css) ->
    chrome.tabs.insertCSS
      file: css
  jss.forEach (js) ->
    chrome.tabs.executeScript 
      file: js
