# referred to http://stackoverflow.com/questions/6850276/how-to-convert-dataurl-to-file-object-in-javascript
dataURLtoBlob = (dataurl) ->
  arr = dataurl.split ','
  mime = arr[0].match(/:(.*?);/)[1]
  bstr = atob(arr[1])
  n = bstr.length
  u8arr = new Uint8Array(n)
  while n--
    u8arr[n] = bstr.charCodeAt(n);
  new Blob [u8arr], {type:mime}


# call cross domain request from eventPage instead of contentScript
# in order to avoid some trouble around https
chrome.runtime.onMessage.addListener (request, sender, callback) ->

  if request.type is 'popup #login'
    chrome.identity.getAuthToken {'interactive': true}, (token) ->
      console.log token
      xhr = new XMLHttpRequest()
      xhr.open 'GET', 'https://www.googleapis.com/plus/v1/people/me'
      xhr.setRequestHeader 'Authorization', "Bearer #{token}"
      xhr.onload = ->
        console.log xhr.status
        console.log xhr.response
        console.log email = JSON.parse(xhr.response).emails[0].value
        chrome.storage.sync.set {email: email}
        callback xhr.response
      xhr.send()

  else if request.type is "contentScript: lookUpWord"
    
    fd = new FormData()
    fd.append "key" , request.key

    xhr = new XMLHttpRequest()
    xhr.open "POST", request.url, true
    xhr.onload = -> callback xhr.responseText
    xhr.onerror = -> callback "failure"  # to clean up the communication port.
    xhr.send fd

  else if request.type is "contentScript: lookUpEijiro"

    xhr = new XMLHttpRequest()
    xhr.open "POST", request.url, true
    xhr.onload = -> callback xhr.responseText
    xhr.onerror = -> callback "failure"  # to clean up the communication port.
    xhr.send()
    console.log "--- request send"

  else if request.type is "contentScript: shootAndUpload"

    # tab capture as data uri scheme
    chrome.tabs.captureVisibleTab (dataurl) ->
      console.log "--- captured"
      console.log dataurl

      chrome.storage.sync.get {cat: "uncategorized", cat_id: 8}, (items) ->

        chrome.storage.sync.get (items) ->
          if items? and items.email?
            fd = new FormData()
            fd.append "picture" , (dataURLtoBlob dataurl), "hello.jpg"
            fd.append "word"    , request.word
            fd.append "sentence", request.sentence
            fd.append "meaning", request.meaning
            fd.append "cat_id"  , items.cat_id
            fd.append "email"  , items.email
           
            xhr = new XMLHttpRequest()
            xhr.open "POST", request.url, true
            xhr.onload = -> callback xhr.responseText
            xhr.onerror = -> callback "failure"  # to clean up the communication port.
            xhr.send fd

  true # prevents the callback from being called too early on return
