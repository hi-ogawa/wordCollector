'use strict'

describe 'Directive: flash', ->

  # load the directive's module
  beforeEach module 'yeomanNgClientApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<flash></flash>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the flash directive'
