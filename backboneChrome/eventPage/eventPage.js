// Generated by CoffeeScript 1.10.0
(function() {
  chrome.runtime.onMessage.addListener(function(request, sender, callback) {
    var data;
    switch (request.type) {
      case "uploadItem":
        data = {
          category_id: request.category_id,
          item: {
            word: request.word,
            sentence: request.sentence,
            meaning: request.meaning,
            picture: extLib.dataURLtoBlob(request.picture)
          }
        };
        $.ajax({
          url: myConfig.domain + "/api/items",
          type: "POST",
          data: extLib.json2FormData(data),
          processData: false,
          contentType: false,
          headers: request.headers
        }).done(function(data) {
          return callback({
            status: "success",
            data: data
          });
        }).fail(function(err) {
          return callback({
            status: "error",
            data: err
          });
        });
        break;
      case "ajax":
        Promise.resolve($.ajax(request.settings)).then(function(data) {
          if (request.settings.dataType === "xml") {
            callback({
              status: "success",
              data: (new XMLSerializer()).serializeToString(data)
            });
          }
          return callback({
            status: "success",
            data: data
          });
        })["catch"](function(err) {
          return callback({
            status: "error",
            data: err
          });
        });
        break;
      case "captureVisibleTab":
        chrome.tabs.captureVisibleTab(function(dataurl) {
          return callback({
            status: "success",
            data: dataurl
          });
        });
        setTimeout((function() {
          return callback({
            status: "error"
          });
        }), 1000);
        break;
      case "createTab":
        chrome.tabs.create({
          url: request.url
        });
        break;
      case "injectBootstrapJS":
        console.log("loading bootstrap.js");
        chrome.tabs.executeScript(null, {
          file: "lib/bootstrap.js"
        });
    }
    return true;
  });

}).call(this);
