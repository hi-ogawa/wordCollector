chrome.runtime.onMessage.addListener (request, sender, callback) ->

  switch request.type

    when "uploadItem"

        data =
          category_id: request.category_id
          item:
            word:      request.word
            sentence:  request.sentence
            meaning:   request.meaning
            picture:   extLib.dataURLtoBlob request.picture
  
        $.ajax
          url:  "#{myConfig.domain}/api/items"
          type: "POST"
          data: extLib.json2FormData data
          processData: false
          contentType: false
          headers: request.headers
        .done (data) -> callback {status: "success", data: data}
        .fail (err) -> callback {status: "error", data: err}

    when "ajax"

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

    when "createTab"
      chrome.tabs.create {url: request.url}

  true # necessary to wait a moment to give arguments to callback
