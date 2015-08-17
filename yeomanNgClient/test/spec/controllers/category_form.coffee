'use strict'

describe 'Controller: CategoryFormCtrl', ->

  # load the controller's module
  beforeEach module 'yeomanNgClientApp'

  CategoryFormCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    CategoryFormCtrl = $controller 'CategoryFormCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(CategoryFormCtrl.awesomeThings.length).toBe 3
