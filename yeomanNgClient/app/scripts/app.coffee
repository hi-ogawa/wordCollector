'use strict'

###*
 # @ngdoc overview
 # @name yeomanNgClientApp
 # @description
 # # yeomanNgClientApp
 #
 # Main module of the application.
###
angular
  .module 'yeomanNgClientApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ui.router'
  ]
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

      # # listing categories
      .state "auth.categories",
        url: "/categories"
        views:
          "userInfoView":
            templateUrl: "views/userInfo.html"
          "authMainView":
            templateUrl: "views/category.html"

      .state "auth.categories.new",
        url: "/:categoryId/edit"
        views:
          "categoryFormView":
            templateUrl: "views/form/categoryForm.html"

      .state "auth.categories.edit",
        url: "/:categoryId/new"
        views:
          "categoryFormView":
            templateUrl: "views/form/categoryForm.html"

      # # listing items
      .state "auth.items",
        url: "/categories/:categoryId/items"
        views:
          "userInfoView":
            templateUrl: "views/userInfo.html"
          "authMainView":
            templateUrl: "views/item.html"

      .state "auth.items.new",
        url: "/:itemId/new"
        views:
          "itemFormView":
            templateUrl: "views/form/itemForm.html"

      .state "auth.items.edit",
        url: "/:itemId/edit"
        views:
          "itemFormView":
            templateUrl: "views/form/itemForm.html"
