describe "AuthService", ->

  AuthService = $resource = $cookies = $httpBackend = null
  userAttr =
    user:
      email:                 "johndoe@john"
      password:              "12345678" 

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
    return
  
  beforeEach inject (_AuthService_, _$resource_, _$cookies_, _$httpBackend_) ->
    [AuthService, $resource, $cookies, $httpBackend] =
      [_AuthService_, _$resource_, _$cookies_, _$httpBackend_]

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe ".getSession", ->
    it "is null initially", ->
      expect(AuthService.getSession()).toEqual null

    it "sets value after .login then set null after .logout", ->
      $httpBackend.expectPOST("/api/sessions", userAttr).respond(response)
      AuthService.login(userAttr)
      $httpBackend.flush()
      expect(AuthService.getSession()).toEqual
        userId: 1
        email:  "johndoe@john"
        token:  "sP3hoKN5-y-tRtagTf2B"
      $httpBackend.expectDELETE("/api/sessions/sP3hoKN5-y-tRtagTf2B").respond({})
      AuthService.logout()
      $httpBackend.flush()
      expect(AuthService.getSession()).toEqual null
