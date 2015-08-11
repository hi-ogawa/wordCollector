HomeController = (UserService, AuthService, $location, FlashService) ->
  vm = @
  vm.flash = FlashService
  vm.auth = AuthService

  UserService.show().then (data) -> vm.displayedName = data.user.email

  vm.delete = ->
    vm.dataLoading = true
    UserService.destroy()
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
HomeController.$inject = ["UserService", "AuthService", "$location", "FlashService"]
angular.module("app")
       .controller 'HomeController', HomeController
