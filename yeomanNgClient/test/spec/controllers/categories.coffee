'use strict'

describe 'Controller: CategoriesCtrl', ->

  # load the controller's module
  beforeEach module 'yeomanNgClientApp'

  CategoriesCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    CategoriesCtrl = $controller 'CategoriesCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(CategoriesCtrl.awesomeThings.length).toBe 3
