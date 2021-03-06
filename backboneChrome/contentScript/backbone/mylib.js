// Generated by CoffeeScript 1.9.3
(function() {
  var lib, root;

  lib = {};

  lib.json2FormData = function(json) {
    var fd;
    fd = new FormData();
    _(json).mapObject(function(val, key) {
      if (!_.isObject(val)) {
        return fd.append(key, val);
      } else {
        return _(val).mapObject(function(valChild, keyChild) {
          return fd.append(key + "[" + keyChild + "]", valChild);
        });
      }
    });
    return fd;
  };

  lib.dataURLtoBlob = function(dataurl) {
    var arr, bstr, mime, n, u8arr;
    arr = dataurl.split(',');
    mime = arr[0].match(/:(.*?);/)[1];
    bstr = atob(arr[1]);
    n = bstr.length;
    u8arr = new Uint8Array(n);
    while (n--) {
      u8arr[n] = bstr.charCodeAt(n);
    }
    return new Blob([u8arr], {
      type: mime
    });
  };

  lib.tabCapture = function(fdHash) {
    return new Promise(function(resolve, reject) {
      chrome.runtime.sendMessage({
        type: "captureVisibleTab"
      }, function(response) {
        switch (response.status) {
          case "success":
            return resolve(response.data);
          case "error":
            return reject("error: lib.tabCapture: error returned from eventPage");
        }
      });
      return setTimeout((function() {
        return reject("error: lib.tabCapture - timeout");
      }), 5000);
    });
  };

  lib.createTab = function(url) {
    return chrome.runtime.sendMessage({
      type: "createTab",
      url: url
    });
  };

  lib.ultraAjax = function(settings) {
    return new Promise(function(resolve, reject) {
      chrome.runtime.sendMessage({
        type: 'ajax',
        settings: settings
      }, function(response) {
        switch (response.status) {
          case "success":
            return resolve(response.data);
          case "error":
            return reject("error: lib.ultraAjax - " + response.data);
        }
      });
      return setTimeout((function() {
        return reject("error: lib.ultraAjax - timeout");
      }), 10000);
    });
  };

  lib.Eijiro = function(word) {
    var promise, url;
    url = "http://eow.alc.co.jp/search?q=" + (encodeURIComponent(word));
    promise = lib.ultraAjax({
      url: url
    });
    return promise.then(function(htmlStr) {
      var data, entriesJQ, html;
      html = $.parseHTML(htmlStr);
      data = {
        dictionary: "Eijiro"
      };
      if ($(html).find('#sas_word').length !== 0) {
        return _.extend(data, {
          type: "suggestions",
          suggestions: $(html).find('#sas_word a').map(function() {
            return $(this).text();
          }).toArray()
        });
      } else {
        entriesJQ = $(html).find('#resultsList > ul > li').map(function() {
          var $ms, entry;
          entry = {
            word: $(this).children('.midashi').text(),
            meanings: []
          };
          $ms = $(this).children('div');
          if ($ms.find('li').length !== 0) {
            $ms.find('li').each(function() {
              return entry.meanings.push($(this).text());
            });
          } else {
            entry.meanings.push($ms.text());
          }
          return entry;
        });
        return _.extend(data, {
          type: "entries",
          entries: entriesJQ.toArray()
        });
      }
    })["catch"](function(err) {
      throw err;
    });
  };

  lib.DictionaryAPI = function(word) {
    var data, promise, url;
    url = "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/" + (encodeURIComponent(word)) + "?key=c4c815db-b3ae-4d2f-8e31-2e556ec300bd";
    promise = lib.ultraAjax({
      url: url,
      dataType: "xml"
    });
    data = {
      dictionary: "Merriam-Webster"
    };
    return promise.then(function(xmlStr) {
      var entriesJQ, xml;
      xml = $.parseXML(xmlStr);
      if ($(xml).find('suggestion').length !== 0) {
        return _.extend(data, {
          type: "suggestions",
          suggestions: $(xml).find("suggestion").map(function() {
            return $(this).text();
          }).toArray()
        });
      } else {
        entriesJQ = $(xml).find('entry').map(function() {
          return {
            word: $(this).attr('id'),
            meanings: $(this).find('def dt').map(function() {
              return $(this).text();
            }).toArray()
          };
        });
        return _.extend(data, {
          type: "entries",
          entries: entriesJQ.toArray()
        });
      }
    })["catch"](function(err) {
      throw err;
    });
  };

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  root.extLib = lib;

}).call(this);
