'use strict'

describe 'Directive: flashMessageD', ->

  # load the directive's module
  beforeEach module 'yeomanNgClientApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<flash-message-d></flash-message-d>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the flashMessageD directive'
