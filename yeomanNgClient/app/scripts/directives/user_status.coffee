'use strict'

###*
 # @ngdoc directive
 # @name yeomanNgClientApp.directive:userStatus
 # @description
 # # userStatus
###
angular.module 'yeomanNgClientApp'
  .directive 'userStatus', (userResource, authService, flashMessage, $state, $window) ->
    restrict: 'EA'
    templateUrl: 'scripts/directives/user_status.html'
    link: (scope, element, attrs) ->
  
      scope.user = userResource.show()
      
      scope.edit = ->
        scope.editing = true
        scope.userForm = angular.copy scope.user
    
      scope.editGo = ->
        scope.editLoading = true
        userResource.update(scope.userForm).$promise
        .then ->
          flashMessage.set "Account updated", "alert-success"
          scope.editLoading = scope.editing = false
        ,->
          FlashService.set("Account update failed", "alert-danger")
          scope.editLoading = scope.editing = false

      scope.delete = ->
        if $window.confirm "do you really want to delete your account"
          scope.loading = true
          userResource.destroy().$promise
          .then ->
            flashMessage.set "Account deleted", "alert-success"
            $state.go "root.register"
          ,->
            flashMessage.set "Account deletion failed", "alert-danger"
            scope.loading = false
  
      scope.logout = ->
        scope.loading = true
        authService.logout()
        .then ->
          flashMessage.set "Logout successful", "alert-success"
          $state.go "root.login"
        ,->
          flashMessage.set "Logout Failed", "alert-danger"
          scope.loading = false
        
