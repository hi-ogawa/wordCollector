// Generated by CoffeeScript 1.9.3
(function() {
  var run;

  run = function($rootScope, $location, $cookieStore, $http) {
    return console.log("angularjs is running...");
  };

  run.$inject = ["$rootScope", "$location", "$cookieStore", "$http"];

  angular.module("app").run(run);

}).call(this);