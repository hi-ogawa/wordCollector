config = ($routeProvider, $locationProvider) ->
  $routeProvider
    .when "/",
        controller:  "HomeController"
        templateUrl: "templates/home.html"
        controllerAs: "vm"

    .when "/login",
        controller:  "LoginController"
        templateUrl: "templates/login.html"
        controllerAs: "vm"

    .when "/register",
        controller:  "RegisterController"
        templateUrl: "templates/register.html"
        controllerAs: "vm"

    .otherwise
        redirectTo: "/login"


config.$inject = ["$routeProvider", "$locationProvider"]

angular.module('app')
       .config(config)
