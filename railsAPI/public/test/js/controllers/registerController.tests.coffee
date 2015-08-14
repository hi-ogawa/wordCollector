describe "RegisterController", ->

  vm = UserService = $location = FlashService = null

  beforeEach module "app"
  beforeEach inject (_UserService_, _$location_, _FlashService_, _$controller_) ->
    [UserService, $location, FlashService] =
      [_UserService_, _$location_, _FlashService_]
    vm = _$controller_ "RegisterController"

  describe "vm.user", ->
    it "", ->
