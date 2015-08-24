'use strict'

angular.module 'yeomanNgClientApp'
  .config ($stateProvider, $urlRouterProvider) ->

    $urlRouterProvider.otherwise "/login"

    $stateProvider

      .state "root",
        templateUrl: "views/root.html"
        controller: "RootCtrl as vm"

      # unauthorized states
      .state "root.register",
        url: "/register"
        views:
          "mainView":
            templateUrl: "views/register.html"
            controller:  "RegisterCtrl as vm"

      .state "root.login",
        url: "/login"
        views:
          "mainView":
            templateUrl: "views/login.html"
            controller:  "LoginCtrl as vm"

      # authorized states
      .state "root.auth",
        views: "mainView":
          templateUrl: "views/auth.html"
          controller:  "AuthCtrl as vm"

      # # listing categories
      .state "categories",
        parent: "root.auth"
        url: "/categories"
        views:
          "authMainView":
            templateUrl: "views/categories.html"
            controller:  "CategoriesCtrl as vm"

      # .state "categories.new",
      #   url: "/:categoryId/new"
      #   views:
      #     "categoryFormView":
      #       templateUrl: "views/form/category_form.html"
      #       controller:  "CategoryFormCtrl as vm"

      # .state "categories.edit",
      #   url: "/:categoryId/edit"
      #   views:
      #     "categoryFormView":
      #       templateUrl: "views/form/category_form.html"
      #       controller:  "CategoryFormCtrl as vm"

      # # listing items
      .state "items",
        parent: "root.auth"
        url: "/categories/:categoryId/items"
        views:
          "authMainView":
            templateUrl: "views/items.html"
            controller:  "ItemsCtrl as vm"

      # .state "items.new",
      #   url: "/:itemId/new"
      #   views:
      #     "itemFormView":
      #       templateUrl: "views/form/item_form.html"
      #       controller:  "ItemFormCtrl as vm"

      # .state "items.edit",
      #   url: "/:itemId/edit"
      #   views:
      #     "itemFormView":
      #       templateUrl: "views/form/item_form.html"
      #       controller:  "ItemFormCtrl as vm"

  # the page visit restriction depending on authorization status
  .run ($rootScope, $state, authService) ->
    publicStates = ["root.register", "root.login"]

    $rootScope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams) ->
      if !authService.getSession() and !_(publicStates).contains(toState.name)
        event.preventDefault()
        $state.go "root.login"
