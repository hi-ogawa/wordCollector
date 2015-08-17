'use strict'

describe 'Controller: RootCtrl', ->

  # load the controller's module
  beforeEach module 'yeomanNgClientApp'

  RootCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    RootCtrl = $controller 'RootCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(RootCtrl.awesomeThings.length).toBe 3
