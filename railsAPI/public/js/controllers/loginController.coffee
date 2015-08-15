LoginController = (AuthService, $location, FlashService) ->
  vm = @
  vm.flash = FlashService

  # vm.sessionForm =
  #   email: "hiogawa@hiogawa"
  #   password: "12345678"
    
  vm.login = ->
    vm.dataLoading = true
    AuthService.login(vm.sessionForm)
    .then ->
      FlashService.set "Login successful", "success"
      $location.path "/category"
    ,->
      FlashService.set "Login failed", "danger"
      vm.dataLoading = false
      FlashService.apply()

  return
LoginController.$inject = ["AuthService", "$location", "FlashService"]
angular.module("app")
       .controller 'LoginController', LoginController
