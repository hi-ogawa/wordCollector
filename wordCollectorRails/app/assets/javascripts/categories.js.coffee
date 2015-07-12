# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# shortest debug
d = (str) -> console.log str

# toggle switch utility
togglize = ($button, call_on, call_off, init) ->
    $button.append($('<span>').addClass('switch').append(' ')
                              .append($('<span>').addClass('on').text('on')).append(' / ')
                              .append($('<span>').addClass('off').text('off')))
    switch init
      when 'on'
        $button.find('.switch').addClass('on')        
        call_on()
      when 'off'
        $button.find('.switch').addClass('off')        
        call_off()
    $button.click ->
      if $button.find('.switch').toggleClass('on off').hasClass('on')
      then call_on() else call_off()

# on/off events
imgEvent = ->
  $('.word img').hide()
  $img = $(this).find('img').show().click -> $(this).hide()

pic_on  = ->
  $('.word img').hide()
  $('.word').on 'mouseover', imgEvent
pic_off = ->
  $('.word img').hide()
  $('.word').off 'mouseover', imgEvent


sel_on  = ->
  $('#changeCat, #deletePosts').removeClass 'strike'
  $('.words').selectable 'enable'
sel_off = ->
  $('#changeCat, #deletePosts').addClass 'strike'
  $('.words .ui-selected').removeClass 'ui-selected'
  $('.words').selectable 'disable'


edit_on  = ->
  $('#applyEdit').removeClass 'strike'
  $('.word, .sentence').each ->
    $(this).find('span').hide()
    $(this).find('input').show()
edit_off = ->
  $('#applyEdit').addClass 'strike'
  $('.word, .sentence').each ->
    $(this).find('span').show()
    $(this).find('input').hide()


sort_on  = ->
  $('#applySort').removeClass 'strike'
  $('.words').sortable 'enable'
sort_off = ->
  $('#applySort').addClass 'strike'
  $('.words').sortable 'disable'


# other events
deletePosts = ->
  selected = $('.ui-selected .word')
  selected_ids = selected.map( -> $(this).attr('post_id')).toArray()
  alert("you're gonna delete these words.\n" +
          selected.map( -> $(this).find('span').text()).toArray().join('\n'))
  $.ajax
    type:        'POST'
    url:         '/multiple_delete'
    data:         JSON.stringify {selected: selected_ids}
    dataType:    'json'
    contentType: 'application/json'
    success: (data) ->
      console.log data
      location.reload()

applyEdit = ->
  edit_ids_words =
    $('.word').filter( ->
      $(this).find('span').text() isnt $(this).find('input').val()
    ).map( ->
      {id: $(this).attr('post_id'), word: $(this).find('input').val()}
    ).toArray()
  edit_ids_sentences =
    $('.sentence').filter( ->
      $(this).find('span').text() isnt $(this).find('input').val()
    ).map( ->
      {id: $(this).attr('post_id'), sentence: $(this).find('input').val()}
    ).toArray()
  $.ajax
    type: 'POST'
    url: '/multiple_edit'
    data:         JSON.stringify {edit_w: edit_ids_words, edit_s: edit_ids_sentences}
    dataType:    'json'
    contentType: 'application/json'
    success: (data) ->
      console.log data
      location.reload()

applySort = ->
  $.ajax
    type: 'POST'
    url: '/sort'
    data: $('.words').sortable('serialize')
    dataType: 'script'
  location.reload()

changeCat = ->
  dest_id = $('#category').val()
  selected = $('.ui-selected .word')
  selected_ids = selected.map( -> $(this).attr('post_id')).toArray()
  $.ajax
    type:        'POST'
    url:         '/change_category'
    data:         JSON.stringify {selected: selected_ids, dest_id: dest_id}
    dataType:    'json'
    contentType: 'application/json'
    success: (data) ->
      console.log data
      location.reload()


ready = ->

  # jquery ui selectable/sortable
  $('.words').selectable({cancel: '.sort-hand, .word, .sentence, .misc'}).selectable 'disable'
  $('.words').sortable({handle: '.sort-hand'}).sortable 'disable'

  # toggle switches
  togglize $('#pictureToggle'),    pic_on,  pic_off,  'off'
  togglize $('#selectableToggle'), sel_on,  sel_off,  'off'
  togglize $('#editableToggle'),   edit_on, edit_off, 'off'
  togglize $('#sortableToggle'),   sort_on, sort_off, 'on'

  $('#changeCat       ').click -> changeCat()    unless $(this).hasClass('strike')
  $('#deletePosts     ').click -> deletePosts()  unless $(this).hasClass('strike')
  $('#applyEdit       ').click -> applyEdit()    unless $(this).hasClass('strike')
  $('#applySort       ').click -> applySort()    unless $(this).hasClass('strike')

$(document).ready ready
$(document).on 'page:load', ready
