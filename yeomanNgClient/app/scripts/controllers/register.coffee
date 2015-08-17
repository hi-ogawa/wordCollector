'use strict'

###*
 # @ngdoc function
 # @name yeomanNgClientApp.controller:RegisterCtrl
 # @description
 # # RegisterCtrl
 # Controller of the yeomanNgClientApp
###
angular.module 'yeomanNgClientApp'
  .controller 'RegisterCtrl', ->
    vm = @

    # test data
    vm.userForm =
      email:                 "test@test.com"
      password:              "12345678"
      password_confirmation: "12345678"

    vm.register = ->
      console.log "on-submit working"

    vm.cancel = ->
      console.log "on-cancel working"
      vm.loading = !vm.loading

    @awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
    return
