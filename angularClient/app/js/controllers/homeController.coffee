HomeController = (UserService, AuthService, $location, FlashService) ->
  vm = @
  vm.flash = FlashService

  vm.show = ->

  vm.delete = ->



  vm.logout = ->
    vm.dataLoading = true
    AuthService.logout()
    .then ->
      FlashService.set("Logout successful", "success")
      $location.path "/login"
    ,->
      vm.dataLoading = false
      FlashService.set("Logout failed, please try again", "danger")
      FlashService.apply()

  return  
HomeController.$inject = ["UserService", "AuthService", "$location", "FlashService"]
angular.module("app")
       .controller 'HomeController', HomeController
