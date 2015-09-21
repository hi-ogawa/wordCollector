'use strict'

###*
 # @ngdoc service
 # @name yeomanNgClientApp.userResource
 # @description
 # # userResource
 # Service in the yeomanNgClientApp.
###
angular.module 'yeomanNgClientApp'
  .service 'userResource', ($resource, authService, apiEndPoint) ->

    r = $resource "#{apiEndPoint}/api/users/:userId", {userId: "@userId"},
          show:
            method: "GET"
            transformResponse: (data) -> angular.fromJson(data).user
            headers:
              Authorization: -> authService.getSession().token
   
          create:
            method: "POST"
   
          update:
            method: "PUT"
            params:
              userId: -> authService.getSession().userId
            headers:
              Authorization: -> authService.getSession().token
   
          destroy:
            method: "DELETE"
            params:
              userId: -> authService.getSession().userId
            headers:
              Authorization: -> authService.getSession().token
   
    service =
      show: (user) -> r.show userId: user.id
   
      create:  (user) ->
        r.create
          user: _(user).pick ["username", "email", "password", "password_confirmation"]
   
      update:  (user) ->
        r.update
          user: _(user).pick ["username", "email", "password", "password_confirmation"]
   
      destroy: -> r.destroy()
   
    return service
