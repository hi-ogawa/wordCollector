// Generated by CoffeeScript 1.9.3
(function() {
  var LoginController;

  LoginController = function(AuthService, $location, FlashService) {
    var vm;
    vm = this;
    vm.flash = FlashService;
    vm.user = {
      email: "hiogawa@hiogawa",
      password: "12345678"
    };
    vm.login = function() {
      vm.dataLoading = true;
      return AuthService.login(vm.user).then(function() {
        FlashService.set("Login successful", "success");
        return $location.path("/category");
      }, function() {
        FlashService.set("Login failed", "danger");
        vm.dataLoading = false;
        return FlashService.apply();
      });
    };
  };

  LoginController.$inject = ["AuthService", "$location", "FlashService"];

  angular.module("app").controller('LoginController', LoginController);

}).call(this);
