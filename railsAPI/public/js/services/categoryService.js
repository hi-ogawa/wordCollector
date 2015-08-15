// Generated by CoffeeScript 1.9.3
(function() {
  var CategoryService;

  CategoryService = function(AuthService, $resource) {
    var r, service;
    r = $resource("/api/categories/:categoryId", {
      categoryId: "@categoryId"
    }, {
      index: {
        method: "GET",
        transformResponse: function(data) {
          return angular.fromJson(data).categories;
        },
        isArray: true
      },
      show: {
        method: "GET",
        transformResponse: function(data) {
          return angular.fromJson(data).category;
        }
      },
      create: {
        method: "POST",
        headers: {
          Authorization: function() {
            return AuthService.getSession().token;
          }
        }
      },
      update: {
        method: "PUT",
        headers: {
          Authorization: function() {
            return AuthService.getSession().token;
          }
        }
      },
      destroy: {
        method: "DELETE",
        headers: {
          Authorization: function() {
            return AuthService.getSession().token;
          }
        }
      }
    });
    service = {
      index: function() {
        return r.index();
      },
      show: function(category) {
        return r.show({
          categoryId: category.id
        });
      },
      create: function(category) {
        return r.create({
          category: _(category).pick(["name", "description"])
        });
      },
      update: function(category) {
        return r.update({
          categoryId: category.id
        }, {
          category: _(category).pick(["name", "description"])
        });
      },
      destroy: function(category) {
        return r.destroy({
          categoryId: category.id
        });
      }
    };
    return service;
  };

  CategoryService.$inject = ["AuthService", "$resource"];

  angular.module("app").factory("CategoryService", CategoryService);

}).call(this);
