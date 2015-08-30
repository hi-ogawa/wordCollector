'use strict'

###*
 # @ngdoc directive
 # @name yeomanNgClientApp.directive:sessionForm
 # @description
 # # sessionForm
###
angular.module 'yeomanNgClientApp'
  .directive 'sessionForm', ->
    restrict: 'EA'
    templateUrl: 'scripts/directives/session_form.html'
    scope:
      sessionForm: "=form"
      submit:      "&onSubmit"
      cancel:      "&onCancel"
      loading:     "="
      labelSubmit: "=" 
      labelCancel: "=" 
    link: (scope, element, attrs) ->
      element.find("input").first().focus()
