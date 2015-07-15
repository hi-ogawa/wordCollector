# dom for monitoring inputs to dictionary
$ext_div0 = $("<div>").attr   "id", "ext_div0"
$input0   = $("<input>").attr "id", "word"
$input1   = $("<input>").attr "id", "sentence"
$input2   = $("<input>").attr "id", "meaning"

# dom for showing meanings/suggestions from dictionary
$ext_div1 = $("<div>").attr   "id", "ext_div1"
$ext_ul = $("<ul>")

# dom for response from eijiro
$ext_div2 = $("<div>").attr   "id", "ext_div2"
$ext_ul2 = $("<ul>")

# adding all doms
$("body").append($ext_div0.append($input0)
                          .append($input1)
                          .append($input2))
         .append($ext_div1.append($ext_ul))
         .append($ext_div2.append($ext_ul2))

$ext_div1.hide()
$ext_div1.dblclick ->
  $input0.val ""
  $input1.val ""
  $input2.val ""
  $ext_div1.hide()

$ext_div2.hide()
$ext_div2.dblclick ->
  $input0.val ""
  $input1.val ""
  $input2.val ""
  $ext_div2.hide()
  $('[data-toggle=popover]').popover 'destroy'

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
      $input0.val "#{$input0.val()} #{w}"
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
    lookUpWord()
    lookUpEijiro()
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
            # $ext_ul.append $('<li>').text $(this).text()
            $a = $('<a>').text($(this).text()).click ->
                    $input2.val $(this).text()
                    shootAndUpload()
            $ext_ul.append $('<li>').append($a)
        else
          # show the suggestions
          $(xml).find('suggestion').each ->
            $a = $('<a>').text($(this).text()).click ->
                    $input0.val $(this).text()
                    lookUpEijiro()
                    lookUpWord()
            $ext_ul.append $('<li>').append($a)

        $ext_div1.show()

lookUpEijiro = ->
  console.log '--- LookUpEijiro'
  console.log voc = $input0.val().trim()
  return if voc == ''
  req_url = "http://eow.alc.co.jp/search?q=#{encodeURIComponent(voc)}"

  # call request from eventPage to avoid https limitation
  chrome.runtime.sendMessage
    type: 'contentScript: lookUpEijiro'
    url: req_url
    , (responseText) ->
        $('[data-toggle=popover]').popover 'destroy'
        $ext_ul2.empty()
        console.log '-- LookUpEijiro : got response --'
        console.log responseText.substring(0,100)
        return if responseText is 'failure'
        html = $.parseHTML(responseText)

        # there's no exact match, but suggestion
        if $(html).find('#sas_word').length isnt 0
          $(html).find('#sas_word a').each ->
            $a = $('<a>').text($(this).text()).click ->
                    $input0.val $(this).text()
                    lookUpEijiro()
                    lookUpWord()
            $ext_ul2.append $('<li>').append($a)

        # there are matches
        else        
          $(html).find('#resultsList > ul > li').each ->
            console.log eng_voc = $(this).children('.midashi').text()
   
            $popover = $('<a>').text(eng_voc)
                               .attr('data-toggle', 'popover')
            $popover_content = $('<ul>')
   
            $mean = (text) ->
              $('<li>').append($('<a>').css('font-size', '10px')
                                       .text(text))
            $meanings = $(this).children('div')
            if $meanings.find('li').length isnt 0
              $meanings.find('li').each ->
                $popover_content.append $mean($(this).text())
            else
              $popover_content.append $mean($meanings.text())
   
            $ext_ul2.append $('<li>').append($popover)
            $popover.popover
                       content: $popover_content.html()
                       html: true
                       placement: 'left'
                       container: 'body'
            $popover.mouseover ->
              $(this).popover 'show'

          $('[data-toggle=popover]').on 'show.bs.popover', ->
            $('[data-toggle=popover]').not($(this)).popover 'hide'

          $('[data-toggle=popover]').on 'shown.bs.popover', ->
            $('.popover-content a').click ->
              $input2.val $(this).text()
              shootAndUpload()
        $ext_div2.show()
  
shootAndUpload = ->
  console.log '--- shootAndUpload'
  chrome.runtime.sendMessage
    type: 'contentScript: shootAndUpload'
    url: 'http://often-test-app.xyz:3005/chrome'
    word: $input0.val().trim()
    sentence: $input1.val().trim()
    meaning: $input2.val().trim()
    , (responseText) ->
        console.log '-- shootAndUpload : got response --'
        console.log responseText
        if $.parseJSON(responseText).status is 'success'
          $ext_ul.prepend $('<li>').text('you got it.')
          $input0.val ''
          $input1.val ''
          $input2.val ''
          $ext_div1.hide()
          $ext_div2.hide()
          $('[data-toggle=popover]').popover 'destroy'
        else
          $ext_ul.prepend $('<li>').text('not good.')


$(document).keydown (e) ->
  if e.altKey and e.shiftKey and e.which == 83
    console.log '--- alt shift 83 ---'
    shootAndUpload()
  else if e.altKey and e.which == 83
    console.log '--- alt 83 ---'
    lookUpWord()
    lookUpEijiro()

$input0.keypress (e) ->
  if e.keyCode is 13
    lookUpWord()
    lookUpEijiro()

chrome.runtime.onMessage.addListener (request, sender, callback) ->
  if request.type is "popup: word_search"
    console.log request.type
    console.log request.word
    console.log $input0.val(request.word)
    console.log $input1.val(request.sentence)
    lookUpWord()
    callback "contentScript: message received, over."
