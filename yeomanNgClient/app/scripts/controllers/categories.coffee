'use strict'

###*
 # @ngdoc function
 # @name yeomanNgClientApp.controller:CategoriesCtrl
 # @description
 # # CategoriesCtrl
 # Controller of the yeomanNgClientApp
###
angular.module 'yeomanNgClientApp'
  .controller 'CategoriesCtrl', (categoryResource, flashMessage, authService, $window) ->
    vm = @

    loadCategories = ->
      vm.categories = categoryResource.index({user_id: authService.getSession().userId})
    loadCategories()

    vm.sumOfNumbersOfItemsIn = (cs) ->
      _.foldl cs, ((n, c) -> n + c.item_ids.length), 0

    vm.newCategory = ->
      vm.showForm = true
      vm.formType = ["New", "Create"]
      vm.categoryForm = null

    vm.editCategory = (category) ->
      vm.showForm = true
      vm.formType = ["Edit", "Update"]
      vm.categoryForm = angular.copy category

    vm.submit = ->
      vm.loading = true
      switch vm.formType[0]
        when "New"
          categoryResource.create(vm.categoryForm).$promise
          .then ->
            flashMessage.set "Successfully created", "alert-success", true
            vm.showForm = vm.dataLoading = false
            loadCategories()
          ,->
            flashMessage.set "Failed to create", "alert-danger", true
            vm.showForm = vm.dataLoading = false
  
        when "Edit"
          categoryResource.update(vm.categoryForm).$promise
          .then ->
            flashMessage.set "Successfully updated", "alert-success", true
            vm.showForm = vm.dataLoading = false
            loadCategories()
          ,->
            flashMessage.set "Failed to update", "alert-danger", true
            vm.showForm = vm.dataLoading = false

    vm.deleteCategory = (category) ->
      if $window.confirm "Are you really sure to delete the category?"
        categoryResource.destroy(category).$promise
        .then ->
          flashMessage.set "Category deleted", "alert-success", true
          loadCategories()
        ,->
          flashMessage.set "Category deletion failed", "alert-danger", true
    return
