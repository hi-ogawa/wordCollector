RegisterController = ($rootScope) ->
  @test = "RegisterController is working"
 
RegisterController.$inject = ['$rootScope']


angular.module("app")
       .controller 'RegisterController', RegisterController
