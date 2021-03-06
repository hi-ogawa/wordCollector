'use strict'

###*
 # @ngdoc directive
 # @name yeomanNgClientApp.directive:userForm
 # @description
 # # userForm
###
angular.module 'yeomanNgClientApp'
  .directive 'userForm', ->
    restrict: 'EA'
    templateUrl: 'scripts/directives/user_form.html'
    scope:
      userForm: "=form"
      submit:   "&onSubmit"
      cancel:   "&onCancel"
      loading:     "="
      labelSubmit: "="
      labelCancel: "="
    link: (scope, element, attrs) ->
      element.find("input").first().focus()
