// Generated by CoffeeScript 1.9.3
(function() {
  var CategoryService;

  CategoryService = function(AuthService, $resource) {
    var r, service;
    r = $resource("/api/categories/:categoryId", {
      categoryId: "@categoryId"
    }, {
      index: {
        method: "GET"
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
      create: function(data) {
        return r.create({
          category: {
            name: data.category.name,
            description: data.category.description
          }
        });
      },
      update: function(data) {
        return r.update({
          categoryId: data.category.id
        });
      },
      destroy: function(data) {
        return r.destroy({
          categoryId: data.category.id
        });
      }
    };
    return service;
  };

  CategoryService.$inject = ["AuthService", "$resource"];

  angular.module("app").factory("CategoryService", CategoryService);

}).call(this);
