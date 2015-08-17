'use strict'

describe 'Controller: ItemsCtrl', ->

  # load the controller's module
  beforeEach module 'yeomanNgClientApp'

  ItemsCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ItemsCtrl = $controller 'ItemsCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(ItemsCtrl.awesomeThings.length).toBe 3
