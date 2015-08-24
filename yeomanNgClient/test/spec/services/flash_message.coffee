'use strict'

describe 'Service: flashMessage', ->

  # load the service's module
  beforeEach module 'yeomanNgClientApp'

  # instantiate service
  flashMessage = {}
  beforeEach inject (_flashMessage_) ->
    flashMessage = _flashMessage_

  it 'should do something', ->
    expect(!!flashMessage).toBe true
