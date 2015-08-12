ItemService = (AuthService, $resource) ->
  r = $resource "/api/items/:itemId", {itemId: "@itemId"},
        index:
          method: "GET"
          transformResponse: (data) -> data.items
          isArray: true

        # show:
        #   method: "GET"

        create:
          method: "POST"
          transformRequest: angular.identity,
          headers:
            Authorization: -> AuthService.getSession().token
            "Content-Type": undefined

        update:
          method: "PUT"
          transformRequest: angular.identity,
          headers:
            Authorization: -> AuthService.getSession().token
            "Content-Type": undefined

        destroy:
          method: "DELETE"
          headers:
            Authorization: -> AuthService.getSession().token

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
    index: -> r.index()

    # show: -> r.show()

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
      r.destroy {itemId: item.id},
        category_id: item.category.id

  return service
ItemService.$inject = ["AuthService", "$resource"]
angular.module("app")
       .factory "ItemService", ItemService
