'use strict'

###*
 # @ngdoc function
 # @name yeomanNgClientApp.controller:FlashctrlCtrl
 # @description
 # # FlashctrlCtrl
 # Controller of the yeomanNgClientApp
###
angular.module 'yeomanNgClientApp'
  .controller 'FlashCtrl', ->
    vm = @
    vm.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
    return
