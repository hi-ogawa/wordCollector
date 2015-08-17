'use strict'

describe 'Controller: AuthCtrl', ->

  # load the controller's module
  beforeEach module 'yeomanNgClientApp'

  AuthCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    AuthCtrl = $controller 'AuthCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(AuthCtrl.awesomeThings.length).toBe 3
