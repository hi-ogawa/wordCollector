// Generated by CoffeeScript 1.9.3
(function() {
  chrome.runtime.onMessage.addListener(function(request, sender, callback) {
    switch (request.type) {
      case "popup":
        return callback({
          status: "success"
        });
    }
  });

}).call(this);