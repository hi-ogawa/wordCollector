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

    vm.categories = categoryResource.index({user_id: authService.getSession().userId})

    vm.sumOfNumbersOfItemsIn = (cs) ->
      _.foldl cs, ((n, c) -> n + c.item_ids.length), 0

    vm.newCategory = ->
      vm.showForm = true
      vm.formType = "new"
      vm.categoryForm = null

    vm.editCategory = (category) ->
      vm.showForm = true
      vm.formType = "edit"
      vm.categoryForm = angular.copy category

    vm.submit = ->
      vm.loading = true
      p =
        switch vm.formType
          when "new"
            categoryResource.create vm.categoryForm
          when "edit"
            categoryResource.update vm.categoryForm
      p.$promise
      .then ->
        flashMessage.set "Successfully Submitted", "alert-success", true
        vm.showForm = vm.dataLoading = false
        vm.categories = categoryResource.index()
      ,->
        flashMessage.set "Submit failed", "alert-danger", true
        vm.showForm = vm.dataLoading = false

    vm.deleteCategory = (category) ->
      if $window.confirm "Are you really sure to delete the category?"
        categoryResource.destroy(category).$promise
        .then ->
          flashMessage.set "category deleted", "alert-success", true
          vm.categories = categoryResource.index()
        ,->
          flashMessage.set "category deletion failed", "alert-danger", true
    return
