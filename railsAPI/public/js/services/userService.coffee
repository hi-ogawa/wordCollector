UserService = (AuthService, $resource) ->
  r = $resource "/api/users/:userId", {userId: "@id"},
        show:
          method: "GET"
          transformResponse: (data) -> data.user
          params:
            userId: -> AuthService.getSession().userId
          headers:
            Authorization: -> AuthService.getSession().token

        create:
          method: "POST"

        update:
          method: "PUT"
          params:
            userId: -> AuthService.getSession().userId
          headers:
            Authorization: -> AuthService.getSession().token

        destroy:
          method: "DELETE"
          params:
            userId: -> AuthService.getSession().userId
          headers:
            Authorization: -> AuthService.getSession().token

  service =
    show: -> r.show()

    create:  (user) -> r.create(user).$promise

    update:  (user) -> r.update(user).$promise

    destroy: -> r.destroy().$promise

  return service
UserService.$inject = ["AuthService", "$resource"]
angular.module("app")
       .factory "UserService", UserService
