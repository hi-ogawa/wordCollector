// Generated by CoffeeScript 1.9.3
(function() {
  chrome.runtime.onMessage.addListener(function(request, sender, callback) {
    var fd, xhr;
    if (request.type === 'set the type as you like') {
      chrome.identity.getAuthToken({
        'interactive': false
      }, function(current_token) {
        return chrome.identity.removeCachedAuthToken({
          token: current_token
        }, function() {});
      });
      chrome.identity.getAuthToken({
        'interactive': true
      }, function(token) {
        return console.log(token);
      });
    } else if (request.type === 'set the type as you like') {
      fd = new FormData();
      fd.append('key', 'value');
      xhr = new XMLHttpRequest();
      xhr.open("POST", request.url, true);
      xhr.onload = function() {
        return callback(xhr.responseText);
      };
      xhr.onerror = function() {
        return callback("failure");
      };
      xhr.send(fd);
    }
    return true;
  });

}).call(this);
