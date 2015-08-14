RegisterController = (UserService, $location, FlashService) ->
  vm = @

  vm.flash = FlashService

  vm.user =
    email: "hiogawa@hiogawa"
    password: "12345678"
    password_confirmation: "12345678"

  vm.submit = ->
    vm.dataLoading = true
    UserService.create(vm.user)
    .then ->
      FlashService.set("Registration successful", "success")
      $location.path "/login"
    ,->
      FlashService.set("Registration failed", "danger")
      vm.dataLoading = false
      FlashService.apply()
    
    
  return
RegisterController.$inject = ["UserService", "$location", "FlashService"]
angular.module("app")
       .controller "RegisterController", RegisterController
