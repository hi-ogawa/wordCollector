'use strict'

###*
 # @ngdoc service
 # @name yeomanNgClientApp.authService
 # @description
 # # authService
 # Service in the yeomanNgClientApp.
###
angular.module 'yeomanNgClientApp'
  .service 'authService', ($resource, $cookies, API_END_POINT) ->

    r = $resource "#{API_END_POINT}/api/sessions/:token", {token: "@id"},
          create:  {method: "POST"}
          destroy: {method: "DELETE"}
   
    currentSession = $cookies.getObject("session") || null
   
    service =
      login: (session) ->
        r.create
          session: _(session).pick ["email", "password"]
        .$promise.then (data) ->
          currentSession =
            userId: data.id
            token:  data.auth_token
          $cookies.putObject("session", currentSession)
   
      logout: ->
        r.destroy
          token: currentSession.token
        .$promise.then ->
          service.delete()
        , ->
          service.delete()

      delete: ->
        currentSession = null
        $cookies.putObject("session", currentSession)
   
      getSession: -> currentSession
      loggedIn: -> !!@getSession()
   
    return service
    
