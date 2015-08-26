'use strict'

xdescribe 'routing', ->

  beforeEach module 'yeomanNgClientApp'

  $state = $rootScope = $httpBackend = $templateCache = $location = null

  stateChanged = null

  beforeEach inject (_$state_, _$rootScope_, _$httpBackend_, _$templateCache_, _$location_) ->
    $state = _$state_
    $rootScope = _$rootScope_
    $httpBackend = _$httpBackend_
    $templateCache = _$templateCache_
    $location = _$location_

    # ui router hidden initialization stuff (default routing is set beforehand)
    $httpBackend.expectGET('views/root.html').respond 200, ""
    $httpBackend.expectGET('views/login.html').respond 200, ""
    $httpBackend.flush()
    expect($location.url()).toEqual "/login"

    stateChanged = false
    $rootScope.$on "$stateChangeSuccess", -> stateChanged = true


  describe "without authentication", ->
    beforeEach module ($provide) ->
      authService = loggedIn: -> false
      $provide.value "authService", authService
      return

    it 'undefined url', ->
      $location.url "/urlNotMatchingAnyState"
      $rootScope.$digest()
      expect(stateChanged).toBeFalsy()
      expect($state.current.name).toEqual "root.login"
   
    it 'root.register', ->
      $httpBackend.expectGET('views/register.html').respond 200, ""
      $state.go "root.register"
      $httpBackend.flush()
      expect(stateChanged).toBeTruthy()
      expect($location.url()).toEqual "/register"
   
    it 'root.login', ->
      $state.go "root.login"
      $rootScope.$digest()
      expect(stateChanged).toBeFalsy()
      expect($location.url()).toEqual "/login"

    it 'redirects any authed page (e.g. `categories`) to `root.login`', ->
      $state.go "categories"
      $rootScope.$digest()
      expect($location.url()).toEqual "/login"

  describe "with authentication", ->
    beforeEach module ($provide) ->
      authService = loggedIn: -> true
      $provide.value "authService", authService
      return

    it "redirects `root.login` to `categories`", ->
      $httpBackend.expectGET('views/categories.html').respond 200, ""
      $state.go "root.login"
      $httpBackend.flush()
      expect($location.url()).toEqual "/categories"

    it "redirects `root.register` to `categories`", ->
      $httpBackend.expectGET('views/categories.html').respond 200, ""
      $state.go "root.register"
      $httpBackend.flush()
      expect($location.url()).toEqual "/categories"

    it "categories", ->
      $httpBackend.expectGET('views/auth.html').respond 200, ""
      $httpBackend.expectGET('views/categories.html').respond 200, ""
      $state.go "categories"
      $httpBackend.flush()
      expect(stateChanged).toBeTruthy()
      expect($location.url()).toEqual "/categories"
   
    it "items", ->
      $httpBackend.expectGET('views/auth.html').respond 200, ""
      $httpBackend.expectGET('views/items.html').respond 200, ""
      $state.go "items", {categoryId: 3}
      $httpBackend.flush()
      expect(stateChanged).toBeTruthy()
      expect($location.url()).toEqual "/categories/3/items"
   
