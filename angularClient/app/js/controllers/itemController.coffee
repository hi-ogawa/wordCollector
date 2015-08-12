ItemController = (ItemService, AuthService, FlashService, $location, $scope) ->
  vm = @

  vm.test = "item controller is working..."

  $scope.$watch (-> vm.myfile), (value) -> console.log value

  return
ItemController.$inject = [
  "ItemService", "AuthService", "FlashService", "$location", "$scope"
]
angular.module("app")
       .controller "ItemController", ItemController

# CategoryController = (CategoryService, UserService, AuthService, FlashService, $location) ->
#   vm = @

#   vm.categories = CategoryService.index()

#   return
# CategoryController.$inject = [
#   "CategoryService", "UserService", "AuthService", "FlashService", "$location"
# ]
# angular.module("app")
#        .controller "CategoryController", CategoryController
