FlashService = ($rootScope, $timeout) ->
  currentMessage = ""
  currentStatus = "" # this could be used as a bootstrap alert class (e.g. success, danger)
  keepedMessage = ""
  keepedStatus  = ""

  apply = ->
    currentMessage = keepedMessage
    currentStatus = keepedStatus
    keepedMessage = ""
    keepedStatus  = ""
    $timeout ->
      currentMessage = ""
      currentStatus  = ""   
    , 2000

  $rootScope.$on "$routeChangeSuccess", ->
    # to get animation work somehow
    $timeout (-> apply()), 10
    
  service =
    getStatus: ->
      currentStatus

    getMessage: ->
      currentMessage

    set: (message, status) ->
      keepedMessage = message
      keepedStatus = status

    apply: ->
      apply()
      # show only 2 seconds

  return service
FlashService.$inject = ["$rootScope", "$timeout"]
angular.module("app")
       .factory "FlashService", FlashService
