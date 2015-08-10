LoginController = (AuthService, $location, FlashService) ->
  vm = @
  vm.flash = FlashService

  vm.user =
    email: "hiogawa@hiogawa"
    password: "12345678"
    
  vm.login = ->
    vm.dataLoading = true
    AuthService.login(vm.user)
    .then ->
      FlashService.set "Login successful", "success"
      $location.path "/"
    ,->
      FlashService.set "Login failed, please try again", "danger"
      vm.dataLoading = false
      FlashService.apply()

  return
LoginController.$inject = ["AuthService", "$location", "FlashService"]
angular.module("app")
       .controller 'LoginController', LoginController
