'use strict'

###*
 # @ngdoc directive
 # @name yeomanNgClientApp.directive:flashMessageD
 # @description
 # # flashMessageD
###
angular.module 'yeomanNgClientApp'
  .directive 'flashMessageD', (flashMessage) ->
    restrict: 'EA'
    templateUrl: 'scripts/directives/flash_message_d.html'
    link: (scope, element, attrs) ->
      scope.flashMessage = flashMessage
