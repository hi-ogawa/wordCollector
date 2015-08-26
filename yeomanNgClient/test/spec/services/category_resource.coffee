'use strict'

describe 'Service: categoryResource', ->

  beforeEach module 'yeomanNgClientApp'

  categoryResource = authService = $resource = null
  
  beforeEach inject (_categoryResource_, _authService_, _$resource_) ->
    categoryResource = _categoryResource_
    authService = _authService_
    $resource = _$resource_

  it 'should do something', ->
    expect(!!categoryResource).toBe true
