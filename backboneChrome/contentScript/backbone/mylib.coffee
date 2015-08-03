lib = {}

lib.dataURLtoBlob = (dataurl) ->
  arr = dataurl.split ','
  mime = arr[0].match(/:(.*?);/)[1]
  bstr = atob(arr[1])
  n = bstr.length
  u8arr = new Uint8Array(n)
  while n--
    u8arr[n] = bstr.charCodeAt(n);
  new Blob [u8arr], {type:mime}


lib.tabCapture = (fdHash) ->
  new Promise (resolve, reject) ->
    chrome.runtime.sendMessage
      type: "captureVisibleTab"
      , (response) ->
        switch response.status
          when "success"
            resolve response.data
          when "error"
            reject "error: lib.tabCapture: error returned from eventPage"
    setTimeout(( -> reject "error: lib.tabCapture - timeout"), 5000)


lib.ultraAjax = (settings) ->

  new Promise (resolve, reject) ->
    chrome.runtime.sendMessage
      type: 'ajax'
      settings: settings
      , (response) ->
        switch response.status
          when "success"
            resolve response.data
          when "error"
            reject "error: lib.ultraAjax - #{response.data}"
    setTimeout(( -> reject "error: lib.ultraAjax - timeout"), 5000)


lib.Eijiro = (word) ->

  url = "http://eow.alc.co.jp/search?q=#{encodeURIComponent(word)}"
  promise = lib.ultraAjax {url: url}
  
  promise.then (htmlStr) ->
    html = $.parseHTML(htmlStr)

    data =
      dictionary: "Eijiro"

    # there's no exact match, but suggestion
    if $(html).find('#sas_word').length isnt 0
      _.extend data,
        type: "suggestions"
        suggestions: $(html).find('#sas_word a').map( -> $(this).text()).toArray()

    # there are matches
    else
      entriesJQ = $(html).find('#resultsList > ul > li').map ->
        entry = 
          word: $(this).children('.midashi').text()
          meanings: []
        
        $ms = $(this).children('div')
        if $ms.find('li').length isnt 0
          $ms.find('li').each -> entry.meanings.push $(this).text()
        else
          entry.meanings.push $ms.text()
        entry

      _.extend data,
        type: "entries"
        entries: entriesJQ.toArray()
  

lib.DictionaryAPI = (word) ->

  url = "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/#{encodeURIComponent(word)}?key=c4c815db-b3ae-4d2f-8e31-2e556ec300bd"

  promise = lib.ultraAjax {url: url, dataType: "xml"}

  data =
    dictionary: "Merriam-Webster"

  promise.then (xmlStr) ->
    xml = $.parseXML xmlStr

    # suggestions
    if $(xml).find('suggestion').length isnt 0
      _.extend data,
        type: "suggestions"
        suggestions: $(xml).find("suggestion").map( -> $(this).text()).toArray()

    # entries
    else
      entriesJQ = $(xml).find('entry').map ->
        word:     $(this).attr('id')
        meanings: $(this).find('def dt').map( -> $(this).text()).toArray()
      _.extend data,
        type: "entries"
        entries: entriesJQ.toArray()


root = exports ? this
root.extLib = lib
