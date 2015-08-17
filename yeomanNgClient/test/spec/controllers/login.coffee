'use strict'

describe 'Controller: LoginCtrl', ->

  # load the controller's module
  beforeEach module 'yeomanNgClientApp'

  LoginCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    LoginCtrl = $controller 'LoginCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(LoginCtrl.awesomeThings.length).toBe 3
