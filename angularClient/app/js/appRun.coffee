run = ($rootScope, $location, AuthService) ->

  publicPages = ["/login", "/register"]

  $rootScope.$on "$locationChangeStart", (event, next, current) ->
    if !AuthService.getSession() and publicPages.indexOf($location.path()) is -1
      $location.path "/login"


run.$inject = ["$rootScope", "$location", "AuthService"]
angular.module("app")
       .run(run)
