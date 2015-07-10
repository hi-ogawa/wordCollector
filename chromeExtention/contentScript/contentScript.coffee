# dom for monitoring inputs to dictionary
$ext_div0 = $("<div>").attr   "id", "ext_div0"
$input0   = $("<input>").attr "id", "word"
$input1   = $("<input>").attr "id", "sentence"

# dom for showing meanings/suggestions from dictionary
$ext_div1 = $("<div>").attr   "id", "ext_div1"
$ext_ul = $("<ul>")

# adding all doms
$("body").append($ext_div0.append($input0)
                          .append($input1))
         .append($ext_div1.append($ext_ul))

$ext_div1.hide()
$ext_div1.dblclick ->
  $input0.val ""
  $input1.val ""
  $ext_div1.hide()

# trick to handle single click (text selection) and double click respectively
DELAY = 200
clicks = 0
timer = null
$('body').on('mouseup', (e) ->
  return if e.altKey or e.shiftKey
  clicks++
  w = window.getSelection().toString().trim()
  return if w == ''
  if clicks == 1
    timer = setTimeout(( ->
      # text selection / single click
      $input0.val (if $input0.val().trim() is "" then w else "#{$input0.val()} #{w}")
      $input1.val window.getSelection().getRangeAt(0).startContainer.parentNode.textContent
      # text selection / single click
      clicks = 0
      return
    ), DELAY)
  else
    clearTimeout timer
    # double click
    $input0.val "#{$input0.val()} #{w}"
    $input1.val window.getSelection().getRangeAt(0).startContainer.parentNode.textContent
    # double click
    clicks = 0
  return
).on 'dblclick', (e) ->
  e.preventDefault()


lookUpWord = ->
  console.log '--- LookUpWord'
  console.log voc = $input0.val().trim()
  console.log s = $input1.val().trim()
  return if voc == ''
  req_url = "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{encodeURIComponent(voc)}"

  # call request from eventPage to avoid https limitation
  chrome.runtime.sendMessage
    type: 'contentScript: lookUpWord'
    url: req_url
    key: 'c4c815db-b3ae-4d2f-8e31-2e556ec300bd'
    , (responseText) ->
        $ext_ul.empty()
        console.log '-- LookUpWord : got response --'
        console.log responseText
        return if responseText is 'failure'

        xml = $.parseXML(responseText)
        if $(xml).find('dt').size() isnt 0
          # show the meanings
          $(xml).find('dt').each ->
            $ext_ul.append $('<li>').text $(this).text()
        else
          # show the suggestions
          $(xml).find('suggestion').each ->
            $ext_ul.append $('<li>').text $(this).text()

        $ext_div1.show()
        if $('.div-alc #alc').length != 0
          l = 'http://eow.alc.co.jp/search?q=' + voc
          $('.div-alc #alc').attr 'src', l
          $('.div-alc #alc').load ->
            $('.div-alc').scrollTop 350


shootAndUpload = ->
  console.log '--- shootAndUpload'
  chrome.runtime.sendMessage
    type: 'contentScript: shootAndUpload'
    url: 'http://often-test-app.xyz:3005/chrome'
    word: $input0.val().trim()
    sentence: $input1.val().trim()
    , (responseText) ->
        console.log '-- shootAndUpload : got response --'
        console.log responseText
        if $.parseJSON(responseText).status is 'success'
          $ext_ul.prepend $('<li>').text('you got it.')
          $input0.val ''
          $input1.val ''
        else
          $ext_ul.prepend $('<li>').text('not good.')


$(document).keydown (e) ->
  if e.altKey and e.shiftKey and e.which == 83
    console.log '--- alt shift 83 ---'
    shootAndUpload()
  else if e.altKey and e.which == 83
    console.log '--- alt 83 ---'
    lookUpWord()



chrome.runtime.onMessage.addListener (request, sender, callback) ->
  if request.type is "popup: word_search"
    console.log request.type
    console.log request.word
    console.log $input0.val(request.word)
    console.log $input1.val(request.sentence)
    lookUpWord()
    callback "contentScript: message received, over."
