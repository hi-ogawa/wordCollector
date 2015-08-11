CategoryService = (AuthService, $resource) ->
  r = $resource "/api/categories/:categoryId", {categoryId: "@categoryId"},
        index:
          method: "GET"

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

    create:  (data) ->
      r.create
        category:
          name:        data.category.name
          description: data.category.description

    update:  (data) ->
      r.update
        categoryId: data.category.id

    destroy: (data) ->
      r.destroy
        categoryId: data.category.id

  return service
CategoryService.$inject = ["AuthService", "$resource"]
angular.module("app")
       .factory "CategoryService", CategoryService
