# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# shortest debug
d = (str) -> console.log str

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

edit_on  = ->
  $('.word, .sentence').each ->
    $(this).find('span').hide()
    $(this).find('input').show()
edit_off = ->
  $('.word, .sentence').each ->
    $(this).find('span').show()
    $(this).find('input').hide()

# other events
deletePosts = ->
  selected = $('.ui-selected')
  selected_ids = selected.map( -> $(this).attr('post_id')).toArray()
  if confirm('are you sure?\n' +
             'you will delete:\n' +
              selected.map( -> $(this).find('.word span').text()).toArray().join('\n'))
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
  if confirm('are you sure?')
    edit_ids_words =
      $('.tr').filter( ->
        $(this).find('.word span').text() isnt $(this).find('.word input').val()
      ).map( ->
        {id: $(this).attr('post_id'), word: $(this).find('.word input').val()}
      ).toArray()
    edit_ids_sentences =
      $('.tr').filter( ->
        $(this).find('.sentence span').text() isnt $(this).find('.sentence input').val()
      ).map( ->
        {id: $(this).attr('post_id'), sentence: $(this).find('.sentence input').val()}
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
  if confirm('are you sure?')
    $.ajax
      type: 'POST'
      url: '/sort'
      data: $('.words').sortable('serialize')
      dataType: 'script'
    location.reload()

changeCat = ->
  if confirm('are you sure?')
    dest_id = $('#category').val()
    selected = $('.ui-selected')
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
  $('.words').selectable({cancel: '.sort-hand, .word, .sentence, .misc'})
  $('.words').sortable({handle: '.sort-hand'})

  # toggle switches
  pic_on()
  edit_off()

  $('#pictureToggle ').bootstrapToggle('on')
  $('#editableToggle').bootstrapToggle('off')

  $('#pictureToggle').change ->
    if $(this).prop 'checked' then pic_on() else pic_off()
  $('#editableToggle').change ->
    if $(this).prop 'checked' then edit_on() else edit_off()

  $('#changeCat       ').click -> changeCat() 
  $('#deletePosts     ').click -> deletePosts()
  $('#applyEdit       ').click -> applyEdit() if $('#editableToggle').prop('checked')
  $('#applySort       ').click -> applySort()
        

$(document).ready ready
$(document).on 'page:load', ready
