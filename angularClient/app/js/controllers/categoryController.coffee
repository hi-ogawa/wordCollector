CategoryController = (CategoryService, UserService, AuthService, FlashService, $location) ->
  vm = @

  vm.test = "message from category controller"

  vm.categories = CategoryService.index()
    

  return
CategoryController.$inject = [
  "CategoryService", "UserService", "AuthService", "FlashService", "$location"
]
angular.module("app")
       .controller "CategoryController", CategoryController
