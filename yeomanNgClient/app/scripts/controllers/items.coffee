'use strict'

###*
 # @ngdoc function
 # @name yeomanNgClientApp.controller:ItemsCtrl
 # @description
 # # ItemsCtrl
 # Controller of the yeomanNgClientApp
###
angular.module 'yeomanNgClientApp'
  .controller 'ItemsCtrl', (itemResource, categoryResource, flashMessage, $stateParams, $sce, $window) ->
    vm = @
    vm.category = categoryResource.show(id: $stateParams.categoryId)
    loadItems = ->
      vm.items = itemResource.index({category_id: $stateParams.categoryId})
    loadItems()


    vm.newItem = ->
      vm.showForm = true
      vm.formType = ["New", "Create"]
      vm.itemForm = null
      
    vm.editItem = (item) ->
      vm.showForm = true
      vm.formType = ["Edit", "Update"]
      vm.itemForm = angular.copy item
      delete vm.itemForm.picture

    vm.submit = ->
      vm.dataLoading = true
      switch vm.formType[0]
        when "New"
          itemResource.create vm.itemForm, $stateParams.categoryId
          .$promise.then ->
            flashMessage.set "Successfully created", "alert-success", true
            vm.showForm = vm.dataLoading = false
            loadItems()
          ,->
            flashMessage.set "Failed to create", "alert-danger", true
            vm.showForm = vm.dataLoading = false

        when "Edit"
          itemResource.update vm.itemForm
          .$promise.then ->
            flashMessage.set "Successfully updated", "alert-success", true
            vm.showForm = vm.dataLoading = false
            loadItems()
          ,->
            flashMessage.set "Failed to update", "alert-danger", true
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
