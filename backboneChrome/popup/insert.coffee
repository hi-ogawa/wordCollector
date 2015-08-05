# insert content scripts only one time
chrome.tabs.query {active: true, currentWindow: true}, (tabs) ->
  chrome.tabs.sendMessage tabs[0].id,
    type: "popup"    
    , (response) ->
      unless response
        console.log "inserting css, js"
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
          'contentScript/backbone/storage.js'
          'contentScript/backbone/app.js'
          'contentScript/contentScript.js'
        ]
        csss.forEach (css) ->
          chrome.tabs.insertCSS
            file: css
        jss.forEach (js) ->
          chrome.tabs.executeScript
            file: js
