FlashService = ($rootScope) ->
  currentMassage = ""
  currentStatus = "" # this could be used as a bootstrap alert class (e.g. success, danger)
  keepedMessage = ""
  keepedStatue  = ""

  
  $rootScope.$on "$routeChangeSuccess", ->
    currentMessage = keepedMessage
    currentStatus = keepedStatus
    keepedMessage = ""
    keepedStatus  = "none"

  service =
    getStatus: ->
      currentStatus

    getMessage: ->
      currentMessage

    set: (message, status) ->
      keepedMessage = message
      keepedStatue  = status

  return service
FlashService.$inject = ["$rootScope"]
angular.module("app")
       .factory "FlashService", FlashService
