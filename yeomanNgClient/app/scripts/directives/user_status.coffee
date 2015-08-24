'use strict'

###*
 # @ngdoc directive
 # @name yeomanNgClientApp.directive:userStatus
 # @description
 # # userStatus
###
angular.module 'yeomanNgClientApp'
  .directive 'userStatus', (userResource, authService, flashMessage, $state) ->
    restrict: 'EA'
    templateUrl: 'scripts/directives/user_status.html'
    link: (scope, element, attrs) ->
  
      scope.user = userResource.show()
      scope.edit = ->
      scope.delete = ->
  
      scope.logout = ->
        scope.loading = true
        authService.logout()
        .then ->
          flashMessage.set "Logout successful", "alert-success"
          $state.go "root.login"
        ,->
          flashMessage.set "Logout Failed", "alert-danger"
          scope.loading = false
        
