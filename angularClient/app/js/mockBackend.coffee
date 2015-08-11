run = ($httpBackend) ->

  $httpBackend.whenGET(/templates\//).passThrough()

  mockResponse = (email) ->
    user:
      id:         1
      email:      email
      auth_token: "sP3hoKN5-y-tRtagTf2B"
      created_at: "2015-08-09T06:00:37.484Z"
      updated_at: "2015-08-09T06:00:37.484Z"
      category_ids: []

  # users controller
  $httpBackend.whenGET(/\/api\/users\/.*/).respond (method, url, data, headers) ->
    console.log "-- mock backend: GET /api/users --"
    console.log url
    console.log headers
    return [200, mockResponse("johndoe@john")]

  $httpBackend.whenPOST('/api/users').respond (method, url, data) ->
    console.log "-- mock backend: POST /api/users --"
    console.log data
    user = angular.fromJson data
    return [201, mockResponse(user.email)]

  $httpBackend.whenPUT(/\/api\/users\/.*/).respond (method, url, data, headers) ->
    console.log "-- mock backend: PUT /api/users --"
    console.log url
    console.log headers
    console.log data
    user = angular.fromJson data
    return [200, mockResponse(user.email)]

  $httpBackend.whenDELETE(/\/api\/users\/.*/).respond (method, url, data, headers) ->
    console.log "-- mock backend: DELETE /api/users --"
    console.log url
    console.log headers
    console.log data
    return [204]

  # sessions controller
  $httpBackend.whenPOST('/api/sessions').respond (method, url, data) ->
    console.log "-- mock backend: POST /api/sessions --"
    console.log data
    user = angular.fromJson data
    return [200, mockResponse(user.email)]

  $httpBackend.whenDELETE(/\/api\/sessions\/.*/).respond (method, url, data, headers) ->
    console.log "-- mock backend: DELETE /api/sessions --"
    console.log url
    console.log data
    console.log headers
    return [204]

run.$inject = ["$httpBackend"]
angular.module("app").run(run)
