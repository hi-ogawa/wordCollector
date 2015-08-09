LoginController = (UserService, $location, FlashService) ->
  vm = @

  vm.flash = FlashService

  vm.user =
    email: "hiogawa@hiogawa"
    password: "12345678"

  onSuccess = (data) ->
    console.log data
    FlashService.set("Login successful", "success")
    $location.path "/home"

  onError   = (err) ->
    console.log err
    FlashService.set("Login failed, please try again", "danger")
    vm.dataLoading = false
    FlashService.apply()
    
  vm.register = ->
    vm.dataLoading = true
    UserService.create(vm.user, onSuccess, onError)

  return
LoginController.$inject = ["AuthService", "$location", "FlashService"]
angular.module("app")
       .controller 'LoginController', LoginController


