'use strict'

###*
 # @ngdoc directive
 # @name yeomanNgClientApp.directive:categoryForm
 # @description
 # # categoryForm
###
angular.module 'yeomanNgClientApp'
  .directive 'categoryForm', ->
    restrict: 'EA'
    templateUrl: 'scripts/directives/category_form.html'
    scope:
      categoryForm: "=form"
      submit:       "&onSubmit"
      cancel:       "&onCancel"
      loading:      "="
