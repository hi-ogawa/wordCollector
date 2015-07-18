showLogin = (show_hide, email) ->
  switch show_hide
    when 'my_show'
      $('#login').removeClass('hide').addClass('show')
      $('#email').removeClass('show').addClass('hide')
    when 'my_hide'  
      $('#login').removeClass('show').addClass('hide')
      $('#email').removeClass('hide').addClass('show')
      $('#email span').text(email)

createCategory = -> 
  chrome.storage.sync.get (items) ->
    if items? and items.email?

      fd = new FormData()
      fd.append "category[name]", $("#categoryName").val()
      fd.append "email", items.email

      xhr = new XMLHttpRequest()
      xhr.open "POST", "http://often-test-app.xyz/chrome_categories_create", true
      # xhr.open "POST", "http://localhost:3000/chrome_categories_create", true
      xhr.onload = ->
        obj = $.parseJSON(xhr.responseText)
        $a = $('<a>').text(obj.name).click ->
                        $('#categoryName').val(obj.name).attr('cat_id', obj.id)
                        chrome.storage.sync.set {cat: obj.name, cat_id: obj.id}
        $(".dropdown-menu").append $("<li>").append($a)
        $a.click()
        categoryNameInputMode 'off'
      xhr.onerror = -> console.log "createCategory xhr failure: #{xhr.responseText}"
      xhr.send(fd)


initCategories = ->
  chrome.storage.sync.get (items) ->
    if items? and items.email?

      fd = new FormData()
      fd.append "email", items.email
     
      xhr = new XMLHttpRequest()
      xhr.open "GET", "http://often-test-app.xyz/chrome_categories_index", true
      # xhr.open "POST", "http://localhost:3000/chrome_categories_index", true
      xhr.onload = ->
        $.parseJSON(xhr.responseText).forEach (c) ->
          $a = $('<a>').text(c.name).click ->
                          $('#categoryName').val(c.name).attr('cat_id', c.id)
                          chrome.storage.sync.set {cat: c.name, cat_id: c.id}
          $(".dropdown-menu").append $("<li>").append($a)
        $('.dropdown-toggle').dropdown()
        chrome.storage.sync.get (items) ->
          if items?
            $('#categoryName').val(items.cat)
                              .attr('cat_id', items.cat_id)
          else
            categoryNameInputMode 'on'
      xhr.onerror = -> console.log "initCategories xhr failure: #{xhr.responseText}"
      xhr.send(fd)


categoryNameInputMode = (on_off) ->
  switch (on_off)
    when 'on'
      $('#createCategory').removeClass 'hide'
      $('#categoryName').removeAttr('readonly')
    when 'off'
      $('#createCategory').addClass 'hide'
      $('#categoryName').attr('readonly','')


wordSearch = ->
  chrome.tabs.query {active: true, currentWindow: true}, (tabs) ->
    chrome.tabs.sendMessage tabs[0].id,
            type:     "popup: word_search"
            word:     $("#word").val()
            sentence: $("#sentence").val()
            , (responseText) -> $(".message").text responseText


$ ->
  # https://developer.chrome.com/extensions/content_scripts#pi
  csss = [
    'lib/my_bootstrap_container.css'
    'contentScript/contentScript.css'
  ]
  jss = [
    'lib/jquery.js'
    'lib/bootstrap.js'
    'contentScript/contentScript.js'
  ]
  csss.forEach (css) ->
    chrome.tabs.insertCSS
      file: css
  jss.forEach (js) ->
    chrome.tabs.executeScript 
      file: js

  # show login button or user's email address
  chrome.storage.sync.get (items) ->
    if items? and items.email?
      showLogin 'my_hide', items.email
    else
      showLogin 'my_show', ''
      $('#login').click ->
         chrome.runtime.sendMessage
                         type: 'popup #login'
                         , (response) -> console.log response

  initCategories()
  $("#createCategory").click -> createCategory()
 
  categoryNameInputMode 'off'
  $('#dropCreateCategory').click -> categoryNameInputMode 'on'
  
  $('#word').keypress (e)     -> if e.keyCode is 13 then wordSearch()
  $('#sentence').keypress (e) -> if e.keyCode is 13 then wordSearch()
  $("#search").click          ->                         wordSearch()
