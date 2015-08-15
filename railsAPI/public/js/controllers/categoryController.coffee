CategoryController = (CategoryService, UserService, AuthService, FlashService, $location, $http) ->
  vm = @
  vm.flash = FlashService

  # category listing
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


  # user account / session manage
  vm.user = UserService.show()
  vm.delete = ->
    vm.dataLoading = true
    UserService.destroy().$promise
    .then ->
      FlashService.set("Account Deleted", "success")
      $location.path "/register"
    ,->
      vm.dataLoading = false
      FlashService.set("Account deletion failed", "danger")
      FlashService.apply()

  vm.logout = ->
    vm.dataLoading = true
    AuthService.logout()
    .then ->
      FlashService.set("Logout successful", "success")
      $location.path "/login"
    ,->
      vm.dataLoading = false
      FlashService.set("Logout failed", "danger")
      FlashService.apply()

  return
CategoryController.$inject = [
  "CategoryService", "UserService", "AuthService", "FlashService", "$location", "$http"
]
angular.module("app")
       .controller "CategoryController", CategoryController
