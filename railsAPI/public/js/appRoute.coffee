config = ($routeProvider, $locationProvider) ->
  $routeProvider
    .when "/",
        redirectTo: "/category"

    .when "/login",
        controller:  "LoginController"
        templateUrl: "templates/login.html"
        controllerAs: "vm"

    .when "/register",
        controller:  "RegisterController"
        templateUrl: "templates/register.html"
        controllerAs: "vm"

    .when "/update",
        controller:  "UpdateController"
        templateUrl: "templates/update.html"
        controllerAs: "vm"

    .when "/category",
        controller:  "CategoryController"
        templateUrl: "templates/category.html"
        controllerAs: "vm"

    .when "/category/:categoryId/item",
        controller:  "ItemController"
        templateUrl: "templates/item.html"
        controllerAs: "vm"

    .otherwise
        redirectTo: "/login"


config.$inject = ["$routeProvider", "$locationProvider"]

angular.module('app')
       .config(config)
