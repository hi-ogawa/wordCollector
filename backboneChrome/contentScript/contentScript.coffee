# # send message to eventPage
# chrome.runtime.sendMessage
#   type: 'contentScript: shootAndUpload'
#   url: 'http://often-test-app.xyz/chrome'
#   word: $input0.val().trim()
#   sentence: $input1.val().trim()
#   meaning: $input2.val().trim()
#   , (responseText) ->
#        console.log responseText

# # receive message from popup
# chrome.runtime.onMessage.addListener (request, sender, callback) ->
#   if request.type is "popup: word_search"
#     console.log request.type
#     console.log request.word
#     console.log $input0.val(request.word)
#     console.log $input1.val(request.sentence)
#     lookUpWord()
#     lookUpEijiro()
#     callback "contentScript: message received, over."


# load the extension content into the body of the page
$extWrapper = $('<div>').attr('id', 'ext-wrapper')
$('body').append $extWrapper
$extWrapper.load chrome.extension.getURL("contentScript/contentScript.html"), ->

  # instantiate backbone app
  new extBackboneApp.AppView()
