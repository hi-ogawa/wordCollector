'use strict'

angular.module 'yeomanNgClientApp'
  .config ($stateProvider, $urlRouterProvider) ->

    $urlRouterProvider.otherwise "/login"

    $stateProvider

      .state "root",
        templateUrl: "views/root.html"

      # unauthorized states
      .state "root.register",
        url: "/register"
        views:
          "MainView":
            templateUrl: "views/register.html"

      .state "root.login",
        url: "/login"
        views:
          "MainView":
            templateUrl: "views/login.html"

      # authorized states
      .state "root.auth",
        views: "mainView":
          templateUrl: "views/auth.html"

      # # listing categories
      .state "categories",
        parent: "root.auth"
        url: "/categories"
        views:
          "authMainView":
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
        parent: "root.auth"
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
