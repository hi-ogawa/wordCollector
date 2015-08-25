'use strict'

describe 'Service: categoryResource', ->

  # load the service's module
  beforeEach module 'yeomanNgClientApp'

  # instantiate service
  categoryResource = {}
  beforeEach inject (_categoryResource_) ->
    categoryResource = _categoryResource_

  it 'should do something', ->
    expect(!!categoryResource).toBe true
