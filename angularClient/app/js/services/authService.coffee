AuthService = ($resource) ->
  return $resource "/api/sessions/:token", {token: "@id"},
      create:  {method: "POST"}
      destroy: {method: "DELETE"}

AuthService.$inject = ["$resource"]
angular.module("app")
       .factory "AuthService", AuthService
