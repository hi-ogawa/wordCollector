'use strict'

###*
 # @ngdoc service
 # @name yeomanNgClientApp.authService
 # @description
 # # authService
 # Service in the yeomanNgClientApp.
###
angular.module 'yeomanNgClientApp'
  .service 'authService', ($resource, $cookies) ->

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
          currentSession = null
          $cookies.putObject("session", currentSession)
        , ->
          currentSession = null
          $cookies.putObject("session", currentSession)
   
      getSession: -> currentSession
      loggedIn: -> !!@getSession()
   
    return service
    
