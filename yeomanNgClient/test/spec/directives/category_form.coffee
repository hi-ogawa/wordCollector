'use strict'

describe 'Directive: categoryForm', ->

  # load the directive's module
  beforeEach module 'yeomanNgClientApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<category-form></category-form>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the categoryForm directive'
