# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

## size balance between .contents and .fixed_wrap in .row
contents_n_fixed_wrap_12_n = (n) ->
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12].forEach (m) ->
    $('.contents, .fixed-wrap').removeClass("col-md-#{m} col-xs-#{m}")
  $('.contents').addClass("col-md-#{n} col-xs-#{n}")
  $('.fixed-wrap').addClass("col-md-#{12 - n} col-xs-#{12 - n}")

## on/off events
pic_on  = ->
  $('.fixed-wrap').show()
  contents_n_fixed_wrap_12_n 8
  $('#picLarge').click()

pic_off = ->
  $('.fixed-wrap').hide()
  contents_n_fixed_wrap_12_n 12
  $('#picSize .btn').removeClass('btn-success').addClass('btn-default')

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

picturePopup = ->
  # magnific-popup library
  $('.image-popup').magnificPopup
                       type: 'image'
                       closeOnContentClick: true
                       zoom: {enabled: true, duration: 300}
                       image: {verticalFit: true}

scrollPictureToWord = ->
  # smooth interaction from pictures to words
  $that = $('<tmp>')
  scrollExecute = ->
    $(".tr .word span").removeClass('mark text-danger')
    $sp = $("[post_id=#{ $that.attr('pic_id') }] .word span")
    $sp.addClass('mark text-danger')
    $('body').animate
      scrollTop: ($sp.offset().top - $(window).height() / 2)
      , 200
  $('.images img').mouseover ->
    $('.images img').removeClass('img-border-color')
    $(this).addClass('img-border-color')
    $that = $(this)
    $this = $(this)
    setTimeout (-> if _.isEqual $that, $this then scrollExecute()), 600

scrollWordToPicture = ->
  # smooth interaction from words to pictures
  $that = $('<tmp>')
  scrollExecute = ->
    pid = $that.parents('.tr').attr('post_id')
    $pic = $("[pic_id=#{pid}]")
    $('.images img').removeClass('img-border-color')
    $pic.addClass('img-border-color')
    $topPic = $('.images img').first()
    $('.images').animate
      scrollTop: (($pic.position().top - $topPic.first().position().top) -
                   $(window).height() / 2 + $pic.height() / 2)
      , 400

  $('.word span').mouseover ->
    $(".tr .word span").removeClass('mark text-danger')
    $(this).addClass('mark text-danger')
    $that = $(this)
    $this = $(this)
    setTimeout (-> if _.isEqual $that, $this then scrollExecute()), 600


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

  $('#picSmall, #picMedium, #picLarge').click ->
    $('#picSize .btn').removeClass('btn-success').addClass('btn-default')
    $(this).addClass('btn-success')
    switch $(this).text()
      when 'S' then contents_n_fixed_wrap_12_n 10
      when 'M' then contents_n_fixed_wrap_12_n 9
      when 'L' then contents_n_fixed_wrap_12_n 8
    $('.images').width($('.fixed-wrap').width())
    $('.images img').width($('.fixed-wrap').width() - 8)
  $('#picLarge').click()
  picturePopup()
  scrollPictureToWord()
  scrollWordToPicture()
  $('.dropdown-toggle').dropdown()
  $('[data-toggle=tooltip]').tooltip()
  
$(document).ready ready
$(document).on 'page:load', ready
