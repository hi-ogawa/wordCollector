'use strict'

describe 'Directive: userForm', ->

  # load the directive's module
  beforeEach module 'yeomanNgClientApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<user-form></user-form>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the userForm directive'
