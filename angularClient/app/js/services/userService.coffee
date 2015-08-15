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

    create:  (user) ->
      r.create
        user: _(user).pick ["email", "password", "password_confirmation"]

    update:  (user) ->
      r.update
        user: _(user).pick ["email", "password", "password_confirmation"]

    destroy: -> r.destroy()

  return service
UserService.$inject = ["AuthService", "$resource"]
angular.module("app")
       .factory "UserService", UserService
