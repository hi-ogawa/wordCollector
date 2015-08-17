'use strict'

describe 'routing', ->

  # load the controller's module
  beforeEach module 'yeomanNgClientApp'

  $state = $rootScope = $httpBackend = $templateCache = $location = null

  # Initialize the controller and a mock scope
  beforeEach inject (_$state_, _$rootScope_, _$httpBackend_, _$templateCache_, _$location_) ->
    $state = _$state_
    $rootScope = _$rootScope_
    $httpBackend = _$httpBackend_
    $templateCache = _$templateCache_
    $location = _$location_

    # mock templates views
    $templateCache.put 'views/root.html', ''
    $templateCache.put 'views/flash.html', ''

    $templateCache.put 'views/unauth.html', ''
    $templateCache.put 'views/register.html', ''
    $templateCache.put 'views/login.html', ''

    $templateCache.put 'views/auth.html', ''
    $templateCache.put 'views/userInfo.html', ''

    $templateCache.put 'views/categories.html', ''
    $templateCache.put 'views/form/categoryForm.html', ''

    $templateCache.put 'views/items.html', ''
    $templateCache.put 'views/form/itemForm.html', ''

  it '', ->
    $location.url "/urlNotMatchingAnyState"
    $rootScope.$digest()
    expect($state.current.name).toEqual "unauth.login"

  it '', ->
    $state.go "unauth.register"
    $rootScope.$digest()
    expect($location.url()).toEqual "/register"

  it '', ->
    $state.go "unauth.login"
    $rootScope.$digest()
    expect($location.url()).toEqual "/login"

  it '', ->
    $state.go "categories"
    $rootScope.$digest()
    expect($location.url()).toEqual "/categories"

  it '', ->
    $state.go "categories.new", {categoryId: 1}
    $rootScope.$digest()
    expect($location.url()).toEqual "/categories/1/new"

  it '', ->
    $state.go "categories.edit", {categoryId: 2}
    $rootScope.$digest()
    expect($location.url()).toEqual "/categories/2/edit"

  it '', ->
    $state.go "items", {categoryId: 3}
    $rootScope.$digest()
    expect($location.url()).toEqual "/categories/3/items"

  it '', ->
    $state.go "items.new", {categoryId: 4, itemId: 6}
    $rootScope.$digest()
    expect($location.url()).toEqual "/categories/4/items/6/new"

  it '', ->
    $state.go "items.edit", {categoryId: 5, itemId: 7}
    $rootScope.$digest()
    expect($location.url()).toEqual "/categories/5/items/7/edit"
