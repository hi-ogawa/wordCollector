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
          headers:
            Authorization: -> AuthService.getSession().token

        update:
          method: "PUT"
          headers:
            Authorization: -> AuthService.getSession().token

        destroy:
          method: "DELETE"
          headers:
            Authorization: -> AuthService.getSession().token

  service =
    index: -> r.index()

    # show: -> r.show()

    create:  (item) ->
      r.create
        category_id: item.category.id
        item: _(item).pick ["word", "sentence", "meaning", "picture"]

    update:  (item) ->
      r.update {itemId: item.id},
        category_id: item.category.id
        item: _(item).pick ["word", "sentence", "meaning", "picture"]

    destroy: (item) ->
      r.destroy {itemId: item.id},
        category_id: item.category.id

  return service
ItemService.$inject = ["AuthService", "$resource"]
angular.module("app")
       .factory "ItemService", ItemService
