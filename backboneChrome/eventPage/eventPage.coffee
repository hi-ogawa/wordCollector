chrome.runtime.onMessage.addListener (request, sender, callback) ->

  if request.type is 'set the type as you like'

    chrome.identity.getAuthToken { 'interactive': false }, (current_token) ->
      chrome.identity.removeCachedAuthToken {token: current_token}, () ->

    chrome.identity.getAuthToken {'interactive': true}, (token) ->
      console.log token

  else if request.type is 'set the type as you like'
    # call cross domain request from eventPage instead of contentScript
    # in order to avoid some trouble around https
    
    fd = new FormData()
    fd.append 'key' , 'value'

    xhr = new XMLHttpRequest()
    xhr.open "POST", request.url, true
    xhr.onload = -> callback xhr.responseText
    xhr.onerror = -> callback "failure"  # to clean up the communication port.
    xhr.send fd
  
  true # prevents the callback from being called too early on return
