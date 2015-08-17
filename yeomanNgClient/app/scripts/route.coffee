'use strict'

angular.module 'yeomanNgClientApp'
  .config ($stateProvider, $urlRouterProvider) ->

    $urlRouterProvider.otherwise "/login"

    $stateProvider

      .state "root",
        templateUrl: "views/root.html"

      .state "root.flash",
        views:
          "flashView@root":
            templateUrl: "views/flash.html"

      # unauthorized states
      .state "unauth",
        parent: "root.flash"
        views: "mainView@root": templateUrl: "views/unauth.html"

      .state "unauth.register",
        url: "/register"
        views:
          "unauthMainView":
            templateUrl: "views/register.html"

      .state "unauth.login",
        url: "/login"
        views:
          "unauthMainView":
            templateUrl: "views/login.html"

      # authorized states
      .state "auth",
        parent:  "root.flash"
        views: "mainView@root": templateUrl: "views/auth.html"

      .state "auth.user",
        views:
          "userInfoView@auth":
            templateUrl: "views/auth.html"

      # # listing categories
      .state "categories",
        parent: "auth.user"
        url: "/categories"
        views:
          "authMainView@auth":
            templateUrl: "views/categories.html"

      .state "categories.new",
        url: "/:categoryId/new"
        views:
          "categoryFormView":
            templateUrl: "views/form/categoryForm.html"

      .state "categories.edit",
        url: "/:categoryId/edit"
        views:
          "categoryFormView":
            templateUrl: "views/form/categoryForm.html"

      # # listing items
      .state "items",
        parent: "auth.user"
        url: "/categories/:categoryId/items"
        views:
          "authMainView":
            templateUrl: "views/items.html"

      .state "items.new",
        url: "/:itemId/new"
        views:
          "itemFormView":
            templateUrl: "views/form/itemForm.html"

      .state "items.edit",
        url: "/:itemId/edit"
        views:
          "itemFormView":
            templateUrl: "views/form/itemForm.html"
