// Generated by CoffeeScript 1.9.3
(function() {
  var CategoryController;

  CategoryController = function(CategoryService, FlashService, $location) {
    var vm;
    vm = this;
    vm.flash = FlashService;
    vm.categories = CategoryService.index();
    vm.showForm = function(category) {
      vm.editing = !!category;
      vm.formOn = true;
      return vm.categoryForm = _.clone(category);
    };
    vm.submit = function() {
      var p;
      vm.dataLoading = true;
      p = vm.editing ? CategoryService.update(vm.categoryForm) : CategoryService.create(vm.categoryForm);
      return p.$promise.then(function() {
        FlashService.set("Successfully Submitted", "success");
        vm.dataLoading = false;
        FlashService.apply();
        return vm.formOn = false;
      }, function() {
        FlashService.set("Submit failed", "danger");
        vm.dataLoading = false;
        FlashService.apply();
        return vm.formOn = false;
      });
    };
    vm.deleteCategory = function(category) {
      return CategoryService.destroy(category);
    };
  };

  CategoryController.$inject = ["CategoryService", "FlashService", "$location"];

  angular.module("app").controller("CategoryController", CategoryController);

}).call(this);
