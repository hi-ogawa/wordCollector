'use strict'

###*
 # @ngdoc function
 # @name yeomanNgClientApp.controller:ItemsCtrl
 # @description
 # # ItemsCtrl
 # Controller of the yeomanNgClientApp
###
angular.module 'yeomanNgClientApp'
  .controller 'ItemsCtrl', (itemResource, categoryResource, flashMessage, $stateParams, $sce) ->
    vm = @
    vm.category = categoryResource.show(id: $stateParams.categoryId)
    vm.items = itemResource.index()

    # change the domain of url and sanitize
    vm.appendDomainBefore = (url) ->
      $sce.trustAsUrl("http://localhost:3000#{url}")
      
    vm.newItem = ->
    vm.editItem = ->
    vm.deleteItem = ->

    
    return
