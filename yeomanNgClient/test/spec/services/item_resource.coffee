'use strict'

describe 'Service: itemResource', ->

  # load the service's module
  beforeEach module 'yeomanNgClientApp'

  # instantiate service
  itemResource = {}
  beforeEach inject (_itemResource_) ->
    itemResource = _itemResource_

  it 'should do something', ->
    expect(!!itemResource).toBe true
