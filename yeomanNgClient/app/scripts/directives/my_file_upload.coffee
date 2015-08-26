'use strict'

###*
 # @ngdoc directive
 # @name yeomanNgClientApp.directive:myFileUpload
 # @description
 # # myFileUpload
###
angular.module 'yeomanNgClientApp'
  .directive 'myFileUpload', ($parse) ->
    restrict: 'EA'
    link: (scope, element, attrs) ->
      element.bind "change", ->
        scope.$apply ->
          $parse(attrs.myFileUpload).assign scope, element[0].files[0]
