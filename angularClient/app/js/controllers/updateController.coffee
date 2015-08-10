UpdateController = (UserService, $location, FlashService) ->
  vm = @

  vm.flash = FlashService

  vm.user =
    email: "hiogawa@hiogawa"
    password: "12345678"
    password_confirmation: "12345678"

  vm.submit = ->
    vm.dataLoading = true
    UserService.update(vm.user)
    .then ->
      FlashService.set("Account updated", "success")
      $location.path "/"
    ,->
      FlashService.set("Account update failed", "danger")
      vm.dataLoading = false
      FlashService.apply()
    
    
  return
UpdateController.$inject = ["UserService", "$location", "FlashService"]
angular.module("app")
       .controller "UpdateController", UpdateController
