'use strict'

describe 'Controller: ItemFormCtrl', ->

  # load the controller's module
  beforeEach module 'yeomanNgClientApp'

  ItemFormCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ItemFormCtrl = $controller 'ItemFormCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(ItemFormCtrl.awesomeThings.length).toBe 3
