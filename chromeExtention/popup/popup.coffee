# shortest debug function
d = (str) -> $(".message").append str

create_category = -> 
  fd = new FormData()
  fd.append "category[name]", $("#category_name").val()

  xhr = new XMLHttpRequest()
  xhr.open "POST", "http://often-test-app.xyz/categories.json", true, 'hiroshi', 'ogawa'
  xhr.onload = ->
    obj = $.parseJSON(xhr.responseText)
    $("#category_list").append $("<option>").val(obj.id).text(obj.name)
    $("#category_list").val(obj.id)
    chrome.storage.sync.set {cat: obj.name, cat_id: obj.id}, ->
      $(".message").text("destination is set to #{obj.name}.")

  xhr.onerror = -> callback "failure"
  xhr.send(fd)

init_categories = ->
  xhr = new XMLHttpRequest()
  xhr.open "GET", "http://often-test-app.xyz/categories.json", true, 'hiroshi', 'ogawa'
  xhr.onload = ->
    $.parseJSON(xhr.responseText).forEach (c) ->
      $("#category_list").append $("<option>").val(c.id).text(c.name)
    chrome.storage.sync.get {cat: "uncategorized", cat_id: 8}, (items) ->
      $("#category_list").val(items.cat_id)
  xhr.onerror = -> callback "failure"
  xhr.send()

word_search = ->
  chrome.tabs.query {active: true, currentWindow: true}, (tabs) ->
    chrome.tabs.sendMessage tabs[0].id,
            type:     "popup: word_search"
            word:     $("#word").val()
            sentence: $("#sentence").val()
            , (responseText) -> $(".message").text responseText

$ ->

  # https://developer.chrome.com/extensions/content_scripts#pi
  csss = [
    'jslib/my_bootstrap_container.css'
    'contentScript/contentScript.css'
  ]
  jss = [
    'jslib/jquery.js'
    'jslib/bootstrap.js'
    'contentScript/contentScript.js'
  ]
  csss.forEach (css) ->
    chrome.tabs.insertCSS
      file: css
  jss.forEach (js) ->
    chrome.tabs.executeScript 
      file: js


  $("#category_name").Watermark "New Category Name"
  $("#word").Watermark "Word"
  $("#sentence").Watermark "Sentence"

  init_categories()
  $("#create_category").click -> create_category()
  $("#category_list").change ->
    cat    = $("#category_list option:selected").text()
    cat_id = $("#category_list").val()
    chrome.storage.sync.set {cat: cat, cat_id: cat_id}, ->
        $(".message").text("destination is set to #{cat}.")

  $("#search").click -> word_search()
  $('#word').keypress (e) ->
          if e.keyCode is 13 then word_search()
  $('#sentence').keypress (e) ->
          if e.keyCode is 13 then word_search()
