run = ($rootScope, $location, $cookieStore, $http) ->
  console.log "angularjs is running..."

run.$inject = ["$rootScope", "$location", "$cookieStore", "$http"]


angular.module("app")
       .run(run)
