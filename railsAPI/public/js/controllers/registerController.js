// Generated by CoffeeScript 1.9.3
(function() {
  var RegisterController;

  RegisterController = function(UserService, $location, FlashService) {
    var vm;
    vm = this;
    vm.flash = FlashService;
    vm.submit = function() {
      vm.dataLoading = true;
      return UserService.create(vm.userForm).$promise.then(function() {
        FlashService.set("Registration successful", "success");
        return $location.path("/login");
      }, function() {
        FlashService.set("Registration failed", "danger");
        vm.dataLoading = false;
        return FlashService.apply();
      });
    };
  };

  RegisterController.$inject = ["UserService", "$location", "FlashService"];

  angular.module("app").controller("RegisterController", RegisterController);

}).call(this);