'use strict'

describe 'Directive: popupImg', ->

  # load the directive's module
  beforeEach module 'yeomanNgClientApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<popup-img></popup-img>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the popupImg directive'
