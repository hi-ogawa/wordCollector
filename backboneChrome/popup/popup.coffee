# chrome.tabs.query {active: true, currentWindow: true}, (tabs) ->
#   chrome.tabs.sendMessage tabs[0].id,
#           type:     'popup: type'
#           , (responseText) -> console.log responseText
