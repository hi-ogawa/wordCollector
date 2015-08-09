HomeController = ($rootScope) ->
  @test = "HomeController is working"
  
HomeController.$inject = ['$rootScope']


angular.module("app")
       .controller 'HomeController', HomeController
