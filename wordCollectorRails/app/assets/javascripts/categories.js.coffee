# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


## on/off events

picturePopup = ->
  $('.image-popup').magnificPopup
                       type: 'image'
                       closeOnContentClick: true
                       zoom: {enabled: true, duration: 300}
                       image: {verticalFit: true}
  $('.images img').mouseover ->
    $(".tr .word span").removeClass('mark text-primary')
    $sp = $("[post_id=#{ $(this).attr('pic_id') }] .word span")
    $sp.addClass('mark text-primary')
    $('body').animate
      scrollTop: ($sp.offset().top - $(window).height() / 2)
      , 200

picturePopUp = ->
  $('.images img').click ->

pic_on  = ->
  $('.fixed-wrap').show()
  $('.contents').removeClass('col-md-12').addClass('col-md-9')
pic_off = ->
  $('.fixed-wrap').hide()
  $('.contents').removeClass('col-md-9').addClass('col-md-12')

edit_on  = ->
  $('.word, .sentence').each ->
    $(this).find('span').hide()
    $(this).find('input').show()
    $('#applyEdit').removeClass('disable')
edit_off = ->
  $('.word, .sentence').each ->
    $(this).find('span').show()
    $(this).find('input').hide()
    $('#applyEdit').addClass('disable')

# other events
deletePosts = ->
  selected = $('.tr.ui-selected')
  selected_ids = selected.map( -> $(this).attr('post_id')).toArray()
  if confirm('are you sure?\n' +
             'you will delete:\n' +
              (selected.map( -> $(this).find('.word span').text()).toArray().join('\n')))
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

changeCat = ($a) ->
  if confirm('are you sure?')
    dest_id = $a.attr('cat_id')
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


init_toggle = ($toggle, call_on, call_off, st) ->
  $toggle.bootstrapToggle st
  $toggle.change ->
    if $(this).prop 'checked' then call_on() else call_off()
  if st is 'on' then call_on() else call_off()


ready = ->

  # jquery ui selectable/sortable
  $('.words').selectable({cancel: '.sort-hand, .word, .sentence, .misc'})
  $('.words').sortable({handle: '.sort-hand'})

  # toggle switches
  init_toggle $('#pictureToggle'), pic_on, pic_off, 'on'
  init_toggle $('#editableToggle'), edit_on, edit_off, 'off'


  $('.changeCat       ').click -> changeCat($(this))
  $('#deletePosts     ').click -> deletePosts()
  $('#applyEdit       ').click -> applyEdit() if $('#editableToggle').prop('checked')
  $('#applySort       ').click -> applySort()

  picturePopup()

$(document).ready ready
$(document).on 'page:load', ready
