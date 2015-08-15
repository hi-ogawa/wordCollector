// Generated by CoffeeScript 1.9.3
(function() {
  var AuthService;

  AuthService = function($resource, $cookies) {
    var currentSession, r, service;
    r = $resource("/api/sessions/:token", {
      token: "@id"
    }, {
      create: {
        method: "POST"
      },
      destroy: {
        method: "DELETE"
      }
    });
    currentSession = $cookies.getObject("session") || null;
    service = {
      login: function(session) {
        return r.create({
          session: _(session).pick(["email", "password"])
        }).$promise.then(function(data) {
          currentSession = {
            userId: data.user.id,
            token: data.user.auth_token
          };
          return $cookies.putObject("session", currentSession);
        });
      },
      logout: function() {
        return r.destroy({
          token: currentSession.token
        }).$promise.then(function() {
          var session;
          session = null;
          return $cookies.putObject("session", session);
        });
      },
      getSession: function() {
        return currentSession;
      }
    };
    return service;
  };

  AuthService.$inject = ["$resource", "$cookies"];

  angular.module("app").factory("AuthService", AuthService);

}).call(this);
