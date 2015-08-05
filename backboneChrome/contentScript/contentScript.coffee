# communicate with popup to achieve only once inserting content scripts
chrome.runtime.onMessage.addListener (request, sender, callback) ->
  switch request.type
    when "popup"
      callback {status: "success"}
