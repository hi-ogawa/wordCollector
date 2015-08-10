AuthService = ($resource, $cookieStore) ->
  r = $resource "/api/sessions/:token", {token: "@id"},
        create:  {method: "POST"}
        destroy: {method: "DELETE"}

  session = $cookieStore.get("session") || null

  service =
    login: (user) ->
      r.create(user).$promise.then (data) ->
        session =
          userId: data.id
          email:  data.email
          token:  data.auth_token
        $cookieStore.put("session", session)

    logout: ->
      r.destroy({token: session.token}).$promise.then ->
        session = null
        $cookieStore.put("session", session)

    getSession: -> session

  return service
AuthService.$inject = ["$resource", "$cookieStore"]
angular.module("app")
       .factory "AuthService", AuthService
