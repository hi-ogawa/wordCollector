CategoryService = (AuthService, $resource) ->
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
CategoryService.$inject = ["AuthService", "$resource"]
angular.module("app")
       .factory "CategoryService", CategoryService
