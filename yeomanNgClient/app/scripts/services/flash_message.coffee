'use strict'

###*
 # @ngdoc service
 # @name yeomanNgClientApp.flashMessage
 # @description
 # # flashMessage
 # Service in the yeomanNgClientApp.
###
angular.module 'yeomanNgClientApp'
  .service 'flashMessage', ->

    service =
      show:    false
      class:   ""
      message: ""
      set: (message, klass) ->
        @message = message
        @class   = klass
        @show = true
      close: ->
        @show = false

    return service
