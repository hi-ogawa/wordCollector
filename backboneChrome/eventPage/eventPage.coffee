chrome.runtime.onMessage.addListener (request, sender, callback) ->

  switch request.type

    when "ajax"
      Promise.resolve($.ajax(request.settings))
        .then((data) ->
          if request.settings.dataType is "xml"
            callback {status: "success", data: (new XMLSerializer()).serializeToString(data)}
          callback {status: "success", data: data})
        .catch((err) ->
          callback {status: "error",   data: err})
      true
