'use strict'

describe 'Controller: FlashctrlCtrl', ->

  # load the controller's module
  beforeEach module 'yeomanNgClientApp'

  FlashctrlCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    FlashctrlCtrl = $controller 'FlashctrlCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(FlashctrlCtrl.awesomeThings.length).toBe 3
