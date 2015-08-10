FlashService = ($rootScope) ->
  currentMessage = ""
  currentStatus = "" # this could be used as a bootstrap alert class (e.g. success, danger)
  keepedMessage = ""
  keepedStatus  = ""

  apply = ->
    currentMessage = keepedMessage
    currentStatus = keepedStatus
    keepedMessage = ""
    keepedStatus  = ""

  $rootScope.$on "$routeChangeSuccess", -> apply()
    
  service =
    getStatus: ->
      currentStatus

    getMessage: ->
      currentMessage

    set: (message, status) ->
      keepedMessage = message
      keepedStatus = status

    apply: apply

  return service
FlashService.$inject = ["$rootScope"]
angular.module("app")
       .factory "FlashService", FlashService
