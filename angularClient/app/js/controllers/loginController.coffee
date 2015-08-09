LoginController = (UserService, $location, FlashService) ->
  vm = @

  vm.flash = FlashService

  vm.user =
    email: "hiogawa@hiogawa"
    password: "12345678"
    password_confirmation: "12345678"

  onSuccess = (data) ->
    console.log data
    FlashService.set("Registration successful", "success")
    $location.path "/login"

  onError   = (err) ->
    console.log err
    FlashService.set("Registration failed, please try again", "error")
    vm.dataLoading = false
    $location.path "/register"
    
  vm.register = ->
    vm.dataLoading = true
    UserService.create(vm.user, onSuccess, onError)

  return
LoginController.$inject = ["UserService", "$location", "FlashService"]
angular.module("app")
       .controller 'LoginController', LoginController


