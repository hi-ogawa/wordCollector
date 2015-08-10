run = ($rootScope, $location, AuthService) ->

  restrictedPages = ["/"]

  $rootScope.$on "$locationChangeStart", (event, next, current) ->
    if !AuthService.getSession() and restrictedPages.indexOf($location.path()) isnt -1
      $location.path "/login"


run.$inject = ["$rootScope", "$location", "AuthService"]
angular.module("app")
       .run(run)
