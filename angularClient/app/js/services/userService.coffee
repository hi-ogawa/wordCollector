UserService = (AuthService, $resource) ->
  return $resource "/api/users/:userId", {userId: "@id"},
      show:    {method: "GET"}
      create:  {method: "POST"}
      update:  {method: "PUT"   , headers: {"Authorization": AuthService.token}}
      destroy: {method: "DELETE", headers: {"Authorization": AuthService.token}}


UserService.$inject = ["AuthService", "$resource"]
angular.module("app")
       .factory "UserService", UserService
