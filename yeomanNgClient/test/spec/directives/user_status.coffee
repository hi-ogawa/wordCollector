'use strict'

describe 'Directive: userStatus', ->

  # load the directive's module
  beforeEach module 'yeomanNgClientApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<user-status></user-status>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the userStatus directive'
