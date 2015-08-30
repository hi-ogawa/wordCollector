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

    # vm.sessionForm =
    #   email:                 "hiogawa@hiogawa.com"
    #   password:              "12345678"

    vm.login = ->
      vm.loading = true
      authService.login(vm.sessionForm)
      .then ->
        flashMessage.set "Login successful", "alert-success", false
        $state.go "categories"
      ,->
        flashMessage.set "Login failed", "alert-danger", true
        vm.loading = false

    vm.cancel = ->
      $state.go "root.register"

    return
