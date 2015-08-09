run = ($httpBackend) ->

  $httpBackend.whenGET(/templates\//).passThrough()

  users = []
  mockResponse = (email) ->
    id:         1
    email:      email
    auth_token: "sP3hoKN5-y-tRtagTf2B"
    created_at: "2015-08-09T06:00:37.484Z"
    updated_at: "2015-08-09T06:00:37.484Z"
    category_ids: []

  $httpBackend.whenPOST('/api/users').respond (method, url, data) ->
    user = angular.fromJson data
    console.log "-- mock backend --"
    console.log user
    users.push user
    return [201, mockResponse(user.email)]


run.$inject = ["$httpBackend"]
angular.module("app").run(run)
