'use strict'

###*
 # @ngdoc function
 # @name yeomanNgClientApp.controller:LoginCtrl
 # @description
 # # LoginCtrl
 # Controller of the yeomanNgClientApp
###
angular.module 'yeomanNgClientApp'
  .controller 'LoginCtrl', (authService, flashMessage, $state) ->
    vm = @

    vm.sessionForm =
      email:                 "test@test.com"
      password:              "12345678"

    vm.login = ->
      vm.loading = true
      authService.login(vm.sessionForm)
      .then ->
        flashMessage.set "Login successful", "alert-success"
        $state.go "categories"
      ,->
        flashMessage.set "Login failed", "alert-danger"
        vm.loading = false

    vm.cancel = ->
    return
