'use strict'

###*
 # @ngdoc function
 # @name yeomanNgClientApp.controller:RegisterCtrl
 # @description
 # # RegisterCtrl
 # Controller of the yeomanNgClientApp
###
angular.module 'yeomanNgClientApp'
  .controller 'RegisterCtrl', (userResource, flashMessage, $state)->
    vm = @

    # test data
    vm.userForm =
      email:                 "test@test.com"
      password:              "12345678"
      password_confirmation: "12345678"

    vm.register = ->
      vm.loading = true
      userResource.create(vm.userForm).$promise
      .then ->
        flashMessage.set "Registration successful", "alert-success"
        $state.go "root.login"
      ,->
        flashMessage.set "Registration failed", "alert-danger"
        vm.loading = false

    vm.cancel = ->

    return
