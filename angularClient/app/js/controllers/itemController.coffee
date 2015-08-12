ItemController = (ItemService, AuthService, FlashService, $location, $routeParams) ->
  vm = @
  vm.flash = FlashService
  vm.items = ItemService.index()

  vm.showForm = (item) ->
    vm.editing = !!item
    vm.formOn = true
    vm.itemForm = _.clone _(item || {}).extend
      category:
        id: $routeParams.categoryId

  vm.submit = ->
    vm.dataLoading = true
    p =
      if vm.editing then ItemService.update vm.itemForm
      else               ItemService.create vm.itemForm
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

  vm.deleteItem = (item) ->
    ItemService.destroy item

  return
ItemController.$inject = [
  "ItemService", "AuthService", "FlashService", "$location", "$routeParams"
]
angular.module("app")
       .controller "ItemController", ItemController
