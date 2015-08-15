AuthService = ($resource, $cookies) ->
  r = $resource "/api/sessions/:token", {token: "@id"},
        create:  {method: "POST"}
        destroy: {method: "DELETE"}

  currentSession = $cookies.getObject("session") || null

  service =
    login: (session) ->
      r.create
        session: _(session).pick ["email", "password"]
      .$promise.then (data) ->
        currentSession =
          userId: data.user.id
          token:  data.user.auth_token
        $cookies.putObject("session", currentSession)

    logout: ->
      r.destroy
        token: currentSession.token
      .$promise.then ->
        session = null
        $cookies.putObject("session", session)

    getSession: -> currentSession

  return service
AuthService.$inject = ["$resource", "$cookies"]
angular.module("app")
       .factory "AuthService", AuthService
