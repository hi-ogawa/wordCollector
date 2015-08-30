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
    scope:
      itemForm: "=form"
      submit:   "&onSubmit"
      cancel:   "&onCancel"
      loading:  "="
      labelSubmit:  "="
      labelCancel:  "="
    link: (scope, element, attrs) ->
      element.find("input").first().focus()
