'use strict'

describe 'Controller: CategoryformCtrl', ->

  # load the controller's module
  beforeEach module 'yeomanNgClientApp'

  CategoryformCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    CategoryformCtrl = $controller 'CategoryformCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(CategoryformCtrl.awesomeThings.length).toBe 3
