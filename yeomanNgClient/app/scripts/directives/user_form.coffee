'use strict'

###*
 # @ngdoc directive
 # @name yeomanNgClientApp.directive:userForm
 # @description
 # # userForm
###
angular.module 'yeomanNgClientApp'
  .directive 'userForm', ->
    restrict: 'AE'
    templateUrl: 'scripts/directives/user_form.html'
    scope:
      userForm: "=form"
      submit:   "&onSubmit"
      cancel:   "&onCancel"
      loading:  "="
