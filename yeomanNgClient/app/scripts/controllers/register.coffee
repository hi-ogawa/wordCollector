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
    # vm.userForm =
    #   username:              "hiogawa"
    #   email:                 "hiogawa@hiogawa.com"
    #   password:              "12345678"
    #   password_confirmation: "12345678"

    vm.register = ->
      vm.loading = true
      userResource.create(vm.userForm).$promise
      .then ->
        flashMessage.set "Registration successful", "alert-success", false
        $state.go "root.login"
      ,->
        flashMessage.set "Registration failed", "alert-danger", true
        vm.loading = false

    vm.cancel = ->
      $state.go "root.login"

    return
