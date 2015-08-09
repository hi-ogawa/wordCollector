AuthService = ->
  return token: ""


AuthService.$inject = []
angular.module("app")
       .factory "AuthService", AuthService
