'use strict'

###*
 # @ngdoc directive
 # @name yeomanNgClientApp.directive:itemForm
 # @description
 # # itemForm
###
angular.module 'yeomanNgClientApp'
  .directive 'itemForm', ->
    restrict: 'EA'
    templateUrl: 'scripts/directives/item_form.html'
    link: (scope, element, attrs) ->
