'use strict'

###*
 # @ngdoc service
 # @name yeomanNgClientApp.flashMessage
 # @description
 # # flashMessage
 # Service in the yeomanNgClientApp.
###
angular.module 'yeomanNgClientApp'
  .service 'flashMessage', ($rootScope) ->

    count = 0
    $rootScope.$on "$stateChangeSuccess", ->
      count++
      if count is 2
        service.close()
        count = 0
      
    service =
      show:    false
      class:   ""
      message: ""
      set: (message, klass) ->
        @message = message
        @class   = klass
        @show    = true
        count = 0
      close: ->
        @show = false

    return service
