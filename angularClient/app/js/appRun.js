// Generated by CoffeeScript 1.9.3
(function() {
  var run;

  run = function($rootScope, $location, AuthService) {
    var publicPages;
    publicPages = ["/login", "/register"];
    return $rootScope.$on("$locationChangeStart", function(event, next, current) {
      if (!AuthService.getSession() && publicPages.indexOf($location.path()) === -1) {
        return $location.path("/login");
      }
    });
  };

  run.$inject = ["$rootScope", "$location", "AuthService"];

  angular.module("app").run(run);

}).call(this);
