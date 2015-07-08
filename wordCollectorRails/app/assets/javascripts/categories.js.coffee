# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


applySort = ->
  $.ajax
    url: '/sort'
    type: 'POST'
    data: $('tbody.words').sortable('serialize')
    dataType: 'script'
  location.reload()


i = false
sortableToggle = ->
  if i
    $('tbody.words').sortable 'destroy'
    $('tbody.words').selectable
      filter: 'tr'
      cancel: 'td.misc, .word img'
  else
    $('tbody.words .ui-selected').removeClass 'ui-selected'
    $('tbody.words').selectable 'destroy'
    $('tbody.words').sortable().disableSelection()
  $('#applySort').toggle()
  i = !i


changeCat = ->
  dest_id = $('#category').val()
  selected = []
  $('tbody tr.ui-selected').each ->
    selected.push $(this).find('.word').attr('post_id')

  $.ajax
    type:        'POST'
    url:         '/hoge'
    data:         JSON.stringify {selected: selected, dest_id: dest_id}
    dataType:    'json'
    contentType: 'application/json'
    success: (data) ->
      console.log data
      location.reload()



ready = ->

  $('.word img').hide()

  $img = $("<img>") # placeholder
  $('.word').mouseover ->
    $img.hide()
    $img = $(this).find('img').show().click -> $img.hide()

  # jquery selectable ui 
  $('tbody.words').selectable
    filter: 'tr'
    cancel: 'td.misc, .word img'


  $('#changeCat').click -> changeCat()
  $('#sortableToggle').click -> sortableToggle()

  $('#applySort').click -> applySort()
  $('#applySort').hide()

  
$(document).ready ready
$(document).on 'page:load', ready
