'use strict'

describe 'Controller: FlashCtrl', ->

  # load the controller's module
  beforeEach module 'yeomanNgClientApp'

  FlashCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    FlashCtrl = $controller 'FlashCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(FlashCtrl.awesomeThings.length).toBe 3
