CategoryService = (AuthService, $resource) ->
  r = $resource "/api/categories/:categoryId", {categoryId: "@id"},
        index:
          method: "GET"

        # show:
        #   method: "GET"

        create:
          method: "POST"

        update:
          method: "PUT"
          headers:
            Authorization: -> AuthService.getSession().token

        destroy:
          method: "DELETE"
          headers:
            Authorization: -> AuthService.getSession().token

  service =
    index: -> r.index().$promise

    # show: -> r.show().$promise

    create:  (category) -> r.create(category).$promise

    update:  (category) -> r.update(category).$promise

    destroy: -> r.destroy().$promise

  return service
CategoryService.$inject = ["AuthService", "$resource"]
angular.module("app")
       .factory "CategoryService", CategoryService
