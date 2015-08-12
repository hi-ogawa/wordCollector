CategoryController = (CategoryService, UserService, AuthService, FlashService, $location) ->
  vm = @

  CategoryService.index().$promise
  .then (data) -> vm.categories = data.categories
    

  return
CategoryController.$inject = [
  "CategoryService", "UserService", "AuthService", "FlashService", "$location"
]
angular.module("app")
       .controller "CategoryController", CategoryController
