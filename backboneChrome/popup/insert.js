// Generated by CoffeeScript 1.9.3
(function() {
  chrome.tabs.query({
    active: true,
    currentWindow: true
  }, function(tabs) {
    return chrome.tabs.sendMessage(tabs[0].id, {
      type: "popup"
    }, function(response) {
      var csss, jss;
      if (!response) {
        console.log("inserting css, js");
        csss = ['lib/my_bootstrap_container.css', 'contentScript/contentScript.css'];
        jss = ['lib/jquery.js', 'lib/bootstrap.js', 'lib/underscore.js', 'lib/backbone.js', 'lib/backbone.localStorage.js', 'contentScript/backbone/mylib.js', 'contentScript/backbone/storage.js', 'contentScript/backbone/app.js', 'contentScript/contentScript.js'];
        csss.forEach(function(css) {
          return chrome.tabs.insertCSS({
            file: css
          });
        });
        return jss.forEach(function(js) {
          return chrome.tabs.executeScript({
            file: js
          });
        });
      }
    });
  });

}).call(this);