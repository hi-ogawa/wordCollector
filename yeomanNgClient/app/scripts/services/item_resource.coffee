'use strict'

###*
 # @ngdoc service
 # @name yeomanNgClientApp.itemResource
 # @description
 # # itemResource
 # Service in the yeomanNgClientApp.
###
angular.module 'yeomanNgClientApp'
  .service 'itemResource', (authService, $resource) ->

    r = $resource "/api/items/:itemId", {itemId: "@itemId"},
          index:
            method: "GET"
            transformResponse: (data) -> angular.fromJson(data).items
            isArray: true
   
          show:
            method: "GET"
            transformResponse: (data) -> angular.fromJson(data).item
   
          create:
            method: "POST"
            transformRequest: angular.identity,
            headers:
              Authorization: -> authService.getSession().token
              "Content-Type": undefined
   
          update:
            method: "PUT"
            transformRequest: angular.identity,
            headers:
              Authorization: -> authService.getSession().token
              "Content-Type": undefined
   
          destroy:
            method: "DELETE"
            headers:
              Authorization: -> authService.getSession().token
   
    # create FormData (able to convert objects up to depth 2)
    json2FormData = (json) ->
      fd = new FormData()
      _(json).mapObject (val, key) ->
        if !_.isObject(val)
          fd.append key, val
        else
          _(val).mapObject (valChild, keyChild) ->
            fd.append "#{key}[#{keyChild}]", valChild
      fd
   
    service =
      index: (params)-> r.index(params)
   
      show: -> r.show()
   
      create:  (item) ->
        fd = json2FormData
          category_id: item.category.id
          item: _(item).pick ["word", "sentence", "meaning", "picture"]
        r.create fd
   
      update:  (item) ->
        r.update {itemId: item.id}, json2FormData
          category_id: item.category.id
          item: _(item).pick ["word", "sentence", "meaning", "picture"]
   
      destroy: (item) ->
        r.destroy {itemId: item.id}
   
    return service
