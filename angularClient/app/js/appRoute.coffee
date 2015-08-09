config = ($routeProvider, $locationProvider) ->
  $routeProvider
    .when "/",
        controller:  "HomeController"
        templateUrl: "templates/home.html"

config.$inject = ["$routeProvider", "$locationProvider"]

angular.module('app')
       .config(config)
