'use strict'

###*
 # @ngdoc service
 # @name yeomanNgClientApp.categoryResource
 # @description
 # # categoryResource
 # Service in the yeomanNgClientApp.
###
angular.module 'yeomanNgClientApp'
  .service 'categoryResource', (authService, $resource) ->
  
    r = $resource "/api/categories/:categoryId", {categoryId: "@categoryId"},
          index:
            method: "GET"
            transformResponse: (data) -> angular.fromJson(data).categories
            isArray: true
   
          show:
            method: "GET"
            transformResponse: (data) -> angular.fromJson(data).category
   
          create:
            method: "POST"
            headers:
              Authorization: -> authService.getSession().token
   
          update:
            method: "PUT"
            headers:
              Authorization: -> authService.getSession().token
   
          destroy:
            method: "DELETE"
            headers:
              Authorization: -> authService.getSession().token
   
    service =
      index: (params) -> r.index(params)
   
      show: (category) -> r.show categoryId: category.id
   
      create:  (category) ->
        r.create
          category: _(category).pick ["name", "description"]
   
      update:  (category) ->
        r.update {categoryId: category.id},
          category: _(category).pick ["name", "description"]
   
      destroy: (category) ->
        r.destroy {categoryId: category.id}
   
    return service
