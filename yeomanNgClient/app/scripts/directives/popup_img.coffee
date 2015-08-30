'use strict'

###*
 # @ngdoc directive
 # @name yeomanNgClientApp.directive:popupImg
 # @description
 # # popupImg
###
angular.module 'yeomanNgClientApp'
  .directive 'popupImg', ->
    restrict: 'EA'
    templateUrl: 'scripts/directives/popup_img.html'
    scope:
      image: "="      
    link: (scope, element, attrs) ->
      element.find("a").magnificPopup
                              type: 'image'
                              closeOnContentClick: true
                              zoom: {enabled: true, duration: 300}
                              image: {verticalFit: true}
