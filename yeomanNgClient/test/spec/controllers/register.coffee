'use strict'

describe 'Controller: RegisterCtrl', ->

  # load the controller's module
  beforeEach module 'yeomanNgClientApp'

  RegisterCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    RegisterCtrl = $controller 'RegisterCtrl', {
      # place here mocked dependencies
    }

  it '', ->
    expect(RegisterCtrl.test).toEqual "RegisterCtrl is working"
