AuthService = ($resource, $cookies) ->
  r = $resource "/api/sessions/:token", {token: "@id"},
        create:  {method: "POST"}
        destroy: {method: "DELETE"}

  session = $cookies.getObject("session") || null

  service =
    login: (user) ->
      r.create(user).$promise.then (data) ->
        session =
          userId: data.user.id
          email:  data.user.email
          token:  data.user.auth_token
        $cookies.putObject("session", session)

    logout: ->
      r.destroy({token: session.token}).$promise.then ->
        session = null
        $cookies.putObject("session", session)

    getSession: -> session

  return service
AuthService.$inject = ["$resource", "$cookies"]
angular.module("app")
       .factory "AuthService", AuthService
