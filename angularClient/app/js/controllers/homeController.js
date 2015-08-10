// Generated by CoffeeScript 1.9.3
(function() {
  var HomeController;

  HomeController = function(UserService, AuthService, $location, FlashService) {
    var vm;
    vm = this;
    vm.flash = FlashService;
    vm.auth = AuthService;
    vm["delete"] = function() {
      vm.dataLoading = true;
      return UserService.destroy().then(function() {
        FlashService.set("Account Deleted", "success");
        return $location.path("/register");
      }, function() {
        vm.dataLoading = false;
        FlashService.set("Account deletion failed", "danger");
        return FlashService.apply();
      });
    };
    vm.logout = function() {
      vm.dataLoading = true;
      return AuthService.logout().then(function() {
        FlashService.set("Logout successful", "success");
        return $location.path("/login");
      }, function() {
        vm.dataLoading = false;
        FlashService.set("Logout failed", "danger");
        return FlashService.apply();
      });
    };
  };

  HomeController.$inject = ["UserService", "AuthService", "$location", "FlashService"];

  angular.module("app").controller('HomeController', HomeController);

}).call(this);
