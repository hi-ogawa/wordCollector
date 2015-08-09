RegisterController = (UserService, $rootScope) ->
  vm = @

  vm.user =
    email: "hiogawa@hiogawa"
    password: "12345678"
    password_confirmation: "12345678"

  vm.register = ->
    newUser = UserService.create(vm.user)
    newUser.$promise.then(((data) -> console.log data), (err) -> console.log err)
  return
 
RegisterController.$inject = ["UserService", "$rootScope"]
angular.module("app")
       .controller "RegisterController", RegisterController
