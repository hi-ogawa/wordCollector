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
    loadItems = ->
      vm.items = itemResource.index({category_id: $stateParams.categoryId})
    loadItems()

    # change the domain of url and sanitize
    vm.appendDomainBefore = (url) ->
      $sce.trustAsUrl("http://localhost:3000#{url}")


    vm.newItem = ->
      vm.showForm = true
      vm.formType = "new"
      vm.itemForm = null
      
    vm.editItem = (item) ->
      vm.showForm = true
      vm.formType = "edit"
      vm.itemForm = angular.copy item

    vm.submit = ->
      vm.loading = true
      p =
        switch vm.formType
          when "new"
            itemResource.create vm.categoryForm
          when "edit"
            itemResource.update vm.categoryForm
      p.$promise
      .then ->
        flashMessage.set "Successfully Submitted", "alert-success", true
        vm.showForm = vm.dataLoading = false
        loadItems()
      ,->
        flashMessage.set "Submit failed", "alert-danger", true
        vm.showForm = vm.dataLoading = false
  
    vm.deleteItem = (item) ->
      if $window.confirm "Are you really sure to delete the category?"
        itemResource.destroy(item).$promise
        .then ->
          flashMessage.set "item deleted", "alert-success", true
          loadItems()
        ,->
          flashMessage.set "item deletion failed", "alert-danger", true
    return
