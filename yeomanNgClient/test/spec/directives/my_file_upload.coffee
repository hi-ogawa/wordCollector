'use strict'

describe 'Directive: myFileUpload', ->

  # load the directive's module
  beforeEach module 'yeomanNgClientApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<my-file-upload></my-file-upload>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the myFileUpload directive'
