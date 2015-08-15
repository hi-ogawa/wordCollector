describe "UserService", ->

  UserService = AuthService = $resource = $httpBackend = null

  createArg = updateArg =
    email:                 "johndoe@john"
    password:              "12345678" 
    password_confirmation: "12345678"

  createPayload = updatePayload =
    user: createArg

  response =
    user:
      id:           1
      email:        "johndoe@john"
      auth_token:   "sP3hoKN5-y-tRtagTf2B"
      created_at:   "2015-08-09T06:00:37.484Z"
      updated_at:   "2015-08-09T06:00:37.484Z"
      category_ids: []

  beforeEach module "app"
  beforeEach module ($provide) ->
    AuthService =
      getSession: ->
        userId: 1
        token:  "sP3hoKN5-y-tRtagTf2B"
    $provide.value "AuthService", AuthService
    return
  
  beforeEach inject (_UserService_, _$resource_, _$httpBackend_) ->
    [UserService, $resource, $httpBackend] =
      [_UserService_, _$resource_, _$httpBackend_]

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe ".show", ->
    it "", ->
      $httpBackend.expectGET("/api/users/1", undefined, (headers) ->
        headers["Authorization"] is "sP3hoKN5-y-tRtagTf2B"
      ).respond(response)
      UserService.show()
      $httpBackend.flush()

  describe ".create", ->
    it "", ->
      $httpBackend.expectPOST("/api/users", createPayload).respond(response)
      UserService.create(createArg)
      $httpBackend.flush()

  describe ".update", ->
    it "", ->
      $httpBackend.expectPUT("/api/users/1", updatePayload, (headers) ->
        headers["Authorization"] is "sP3hoKN5-y-tRtagTf2B"
      ).respond(response)
      UserService.update(createArg)
      $httpBackend.flush()

  describe ".delete", ->
    it "", ->
      $httpBackend.expectDELETE("/api/users/1", undefined, (headers) ->
        headers["Authorization"] is "sP3hoKN5-y-tRtagTf2B"
      ).respond(response)
      UserService.destroy()
      $httpBackend.flush()
