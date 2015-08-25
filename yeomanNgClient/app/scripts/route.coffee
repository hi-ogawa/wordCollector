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

      # # listing items
      .state "items",
        parent: "root.auth"
        url: "/categories/:categoryId/items"
        views:
          "authMainView":
            templateUrl: "views/items.html"
            controller:  "ItemsCtrl as vm"

  # redirect user depending on the authorization status
  .run ($rootScope, $state, authService) ->
    publicStates = ["root.register", "root.login"]
    __ = (st) -> isPublic: -> _(publicStates).contains(st.name)

    $rootScope.$on "$stateChangeStart", (event, toState, toParams, fromState, fromParams) ->

      if __(toState).isPublic() and authService.loggedIn()
        event.preventDefault()
        $state.go "categories"

      else if !__(toState).isPublic() and !authService.loggedIn()
        event.preventDefault()
        $state.go "root.login"
