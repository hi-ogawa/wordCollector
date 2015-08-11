CategoryController = (CategoryService, UserService, AuthService, FlashService, $location) ->
  vm = @

  vm.test = "message from category controller"
    

  return
CategoryController.$inject = [
  "CategoryService", "UserService", "AuthService", "FlashService", "$location"
]
angular.module("app")
       .controller "CategoryController", CategoryController
