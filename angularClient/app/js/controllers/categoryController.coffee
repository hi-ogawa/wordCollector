CategoryController = (CategoryService, FlashService, $location) ->
  vm = @
  vm.flash = FlashService
  vm.categories = CategoryService.index()
  vm.sum_items = (cs) ->
    _.foldl vm.categories, ((n, c) -> n + c.item_ids.length), 0

  vm.showForm = (category) ->
    vm.editing = !!category
    vm.formOn = true
    vm.categoryForm = _.clone(category)

  vm.submit = ->
    vm.dataLoading = true
    p =
      if vm.editing then CategoryService.update vm.categoryForm
      else               CategoryService.create vm.categoryForm
    p.$promise
    .then ->
      FlashService.set("Successfully Submitted", "success")
      vm.dataLoading = false
      FlashService.apply()
      vm.formOn = false
    ,->
      FlashService.set("Submit failed", "danger")
      vm.dataLoading = false
      FlashService.apply()
      vm.formOn = false
  

  vm.deleteCategory = (category) ->
    CategoryService.destroy category
    
  return
CategoryController.$inject = [
  "CategoryService", "FlashService", "$location"
]
angular.module("app")
       .controller "CategoryController", CategoryController
