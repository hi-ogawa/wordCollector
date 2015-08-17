'use strict'

describe 'Service: userResource', ->

  # load the service's module
  beforeEach module 'yeomanNgClientApp'

  # instantiate service
  userResource = {}
  beforeEach inject (_userResource_) ->
    userResource = _userResource_

  it 'should do something', ->
    expect(!!userResource).toBe true
