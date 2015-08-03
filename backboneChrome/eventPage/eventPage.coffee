chrome.runtime.onMessage.addListener (request, sender, callback) ->

  switch request.type

    when "ajax"

      # adhocly, convert dataurl into blob (since blob object cannot be passed as a message),
      # which I don't like to do most :(
      if request.settings.data?
        fd = new FormData
        _.mapObject request.settings.data, (val, key) ->
          if key is "picture"
            fd.append key, extLib.dataURLtoBlob(val)
          else
            fd.append key, val
        request.settings.data = fd

      Promise.resolve($.ajax(request.settings))
        .then((data) ->
          if request.settings.dataType is "xml"
            callback {status: "success", data: (new XMLSerializer()).serializeToString(data)}
          callback {status: "success", data: data})
        .catch((err) ->
          callback {status: "error",   data: err})

    when "captureVisibleTab"
      chrome.tabs.captureVisibleTab (dataurl) ->
        callback {status: "success", data: dataurl}
      setTimeout(( -> callback {status: "error"}), 1000)

  true # necessary to wait a moment to give arguments to callback
