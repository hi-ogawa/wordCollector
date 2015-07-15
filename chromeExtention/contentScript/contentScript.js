// Generated by CoffeeScript 1.9.3
(function() {
  var $ext_div0, $ext_div1, $ext_div2, $ext_ul, $ext_ul2, $input0, $input1, $input2, DELAY, clicks, lookUpEijiro, lookUpWord, shootAndUpload, timer;

  $ext_div0 = $("<div>").attr("id", "ext_div0");

  $input0 = $("<input>").attr("id", "word");

  $input1 = $("<input>").attr("id", "sentence");

  $input2 = $("<input>").attr("id", "meaning");

  $ext_div1 = $("<div>").attr("id", "ext_div1");

  $ext_ul = $("<ul>");

  $ext_div2 = $("<div>").attr("id", "ext_div2");

  $ext_ul2 = $("<ul>");

  $("body").append($ext_div0.append($input0).append($input1).append($input2)).append($ext_div1.append($ext_ul)).append($ext_div2.append($ext_ul2));

  $ext_div1.hide();

  $ext_div1.dblclick(function() {
    $input0.val("");
    $input1.val("");
    $input2.val("");
    return $ext_div1.hide();
  });

  $ext_div2.hide();

  $ext_div2.dblclick(function() {
    $input0.val("");
    $input1.val("");
    $input2.val("");
    $ext_div2.hide();
    return $('[data-toggle=popover]').popover('destroy');
  });

  DELAY = 200;

  clicks = 0;

  timer = null;

  $('body').on('mouseup', function(e) {
    var w;
    if (e.altKey || e.shiftKey) {
      return;
    }
    clicks++;
    w = window.getSelection().toString().trim();
    if (w === '') {
      return;
    }
    if (clicks === 1) {
      timer = setTimeout((function() {
        $input0.val(($input0.val()) + " " + w);
        $input1.val(window.getSelection().getRangeAt(0).startContainer.parentNode.textContent);
        clicks = 0;
      }), DELAY);
    } else {
      clearTimeout(timer);
      $input0.val(($input0.val()) + " " + w);
      $input1.val(window.getSelection().getRangeAt(0).startContainer.parentNode.textContent);
      lookUpWord();
      lookUpEijiro();
      clicks = 0;
    }
  }).on('dblclick', function(e) {
    return e.preventDefault();
  });

  lookUpWord = function() {
    var req_url, s, voc;
    console.log('--- LookUpWord');
    console.log(voc = $input0.val().trim());
    console.log(s = $input1.val().trim());
    if (voc === '') {
      return;
    }
    req_url = "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/" + (encodeURIComponent(voc));
    return chrome.runtime.sendMessage({
      type: 'contentScript: lookUpWord',
      url: req_url,
      key: 'c4c815db-b3ae-4d2f-8e31-2e556ec300bd'
    }, function(responseText) {
      var xml;
      $ext_ul.empty();
      console.log('-- LookUpWord : got response --');
      console.log(responseText);
      if (responseText === 'failure') {
        return;
      }
      xml = $.parseXML(responseText);
      if ($(xml).find('dt').size() !== 0) {
        $(xml).find('dt').each(function() {
          var $a;
          $a = $('<a>').text($(this).text()).click(function() {
            $input2.val($(this).text());
            return shootAndUpload();
          });
          return $ext_ul.append($('<li>').append($a));
        });
      } else {
        $(xml).find('suggestion').each(function() {
          var $a;
          $a = $('<a>').text($(this).text()).click(function() {
            $input0.val($(this).text());
            lookUpEijiro();
            return lookUpWord();
          });
          return $ext_ul.append($('<li>').append($a));
        });
      }
      return $ext_div1.show();
    });
  };

  lookUpEijiro = function() {
    var req_url, voc;
    console.log('--- LookUpEijiro');
    console.log(voc = $input0.val().trim());
    if (voc === '') {
      return;
    }
    req_url = "http://eow.alc.co.jp/search?q=" + (encodeURIComponent(voc));
    return chrome.runtime.sendMessage({
      type: 'contentScript: lookUpEijiro',
      url: req_url
    }, function(responseText) {
      var html;
      $('[data-toggle=popover]').popover('destroy');
      $ext_ul2.empty();
      console.log('-- LookUpEijiro : got response --');
      console.log(responseText.substring(0, 100));
      if (responseText === 'failure') {
        return;
      }
      html = $.parseHTML(responseText);
      if ($(html).find('#sas_word').length !== 0) {
        $(html).find('#sas_word a').each(function() {
          var $a;
          $a = $('<a>').text($(this).text()).click(function() {
            $input0.val($(this).text());
            lookUpEijiro();
            return lookUpWord();
          });
          return $ext_ul2.append($('<li>').append($a));
        });
      } else {
        $(html).find('#resultsList > ul > li').each(function() {
          var $mean, $meanings, $popover, $popover_content, eng_voc;
          console.log(eng_voc = $(this).children('.midashi').text());
          $popover = $('<a>').text(eng_voc).attr('data-toggle', 'popover');
          $popover_content = $('<ul>');
          $mean = function(text) {
            return $('<li>').append($('<a>').css('font-size', '10px').text(text));
          };
          $meanings = $(this).children('div');
          if ($meanings.find('li').length !== 0) {
            $meanings.find('li').each(function() {
              return $popover_content.append($mean($(this).text()));
            });
          } else {
            $popover_content.append($mean($meanings.text()));
          }
          $ext_ul2.append($('<li>').append($popover));
          $popover.popover({
            content: $popover_content.html(),
            html: true,
            placement: 'left',
            container: 'body'
          });
          return $popover.mouseover(function() {
            return $(this).popover('show');
          });
        });
        $('[data-toggle=popover]').on('show.bs.popover', function() {
          return $('[data-toggle=popover]').not($(this)).popover('hide');
        });
        $('[data-toggle=popover]').on('shown.bs.popover', function() {
          return $('.popover-content a').click(function() {
            $input2.val($(this).text());
            return shootAndUpload();
          });
        });
      }
      return $ext_div2.show();
    });
  };

  shootAndUpload = function() {
    console.log('--- shootAndUpload');
    return chrome.runtime.sendMessage({
      type: 'contentScript: shootAndUpload',
      url: 'http://often-test-app.xyz:3005/chrome',
      word: $input0.val().trim(),
      sentence: $input1.val().trim(),
      meaning: $input2.val().trim()
    }, function(responseText) {
      console.log('-- shootAndUpload : got response --');
      console.log(responseText);
      if ($.parseJSON(responseText).status === 'success') {
        $ext_ul.prepend($('<li>').text('you got it.'));
        $input0.val('');
        $input1.val('');
        $input2.val('');
        $ext_div1.hide();
        $ext_div2.hide();
        return $('[data-toggle=popover]').popover('destroy');
      } else {
        return $ext_ul.prepend($('<li>').text('not good.'));
      }
    });
  };

  $(document).keydown(function(e) {
    if (e.altKey && e.shiftKey && e.which === 83) {
      console.log('--- alt shift 83 ---');
      return shootAndUpload();
    } else if (e.altKey && e.which === 83) {
      console.log('--- alt 83 ---');
      lookUpWord();
      return lookUpEijiro();
    }
  });

  $input0.keypress(function(e) {
    if (e.keyCode === 13) {
      lookUpWord();
      return lookUpEijiro();
    }
  });

  chrome.runtime.onMessage.addListener(function(request, sender, callback) {
    if (request.type === "popup: word_search") {
      console.log(request.type);
      console.log(request.word);
      console.log($input0.val(request.word));
      console.log($input1.val(request.sentence));
      lookUpWord();
      return callback("contentScript: message received, over.");
    }
  });

}).call(this);
