'use strict'

describe 'routing', ->

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

  describe "state: categories", ->
    beforeEach ->
      $httpBackend.expectGET('views/auth.html').respond 200, ""
      $httpBackend.expectGET('views/categories.html').respond 200, ""

    it 'categories', ->
      $state.go "categories"
      $httpBackend.flush()
      expect(stateChanged).toBeTruthy()
      expect($location.url()).toEqual "/categories"
   
    it 'categories.new', ->
      $httpBackend.expectGET('views/form/categoryForm.html').respond 200, ""
      $state.go "categories.new", {categoryId: 1}
      $httpBackend.flush()
      expect(stateChanged).toBeTruthy()
      expect($location.url()).toEqual "/categories/1/new"
   
    it 'categories.edit', ->
      $httpBackend.expectGET('views/form/categoryForm.html').respond 200, ""
      $state.go "categories.edit", {categoryId: 2}
      $httpBackend.flush()
      expect(stateChanged).toBeTruthy()
      expect($location.url()).toEqual "/categories/2/edit"

  describe "state: items", ->
    beforeEach ->
      $httpBackend.expectGET('views/auth.html').respond 200, ""
      $httpBackend.expectGET('views/items.html').respond 200, ""

    it 'items', ->
      $state.go "items", {categoryId: 3}
      $httpBackend.flush()
      expect(stateChanged).toBeTruthy()
      expect($location.url()).toEqual "/categories/3/items"
   
    it 'items.new', ->
      $httpBackend.expectGET('views/form/itemForm.html').respond 200, ""
      $state.go "items.new", {categoryId: 4, itemId: 6}
      $httpBackend.flush()
      expect(stateChanged).toBeTruthy()
      expect($location.url()).toEqual "/categories/4/items/6/new"
   
    it 'items.edit', ->
      $httpBackend.expectGET('views/form/itemForm.html').respond 200, ""
      $state.go "items.edit", {categoryId: 5, itemId: 7}
      $httpBackend.flush()
      expect(stateChanged).toBeTruthy()
      expect($location.url()).toEqual "/categories/5/items/7/edit"
