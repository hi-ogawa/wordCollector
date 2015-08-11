describe "UserService", ->

  UserService = AuthService = $resource = $httpBackend = null
  userAttr =
    user:
      email:                 "johndoe@john"
      password:              "12345678" 
      password_confirmation: "12345678"

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
        userId: 2
        token:  "sP3hoKN5-y-tRtagTf2B"
    $provide.value "AuthService", AuthService
    return
  
  beforeEach inject (_UserService_, _$resource_, _$httpBackend_) ->
    [UserService, $resource, $httpBackend] =
      [_UserService_, _$resource_, _$httpBackend_]

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe ".create", ->
    it "", ->
      $httpBackend.expectPOST("/api/users", userAttr).respond( -> [201])
      UserService.create(userAttr)
      $httpBackend.flush()

  describe ".update", ->
    it "", ->
      $httpBackend.expectPUT("/api/users/2", userAttr, (headers) ->
        headers["Authorization"] is "sP3hoKN5-y-tRtagTf2B"
      ).respond( -> [200])
      UserService.update(userAttr)
      $httpBackend.flush()
