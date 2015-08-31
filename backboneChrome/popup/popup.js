// Generated by CoffeeScript 1.9.3
(function() {
  var app;

  app = {};


  /* storage for authentication and destination category */

  app.storage = new MyStorage();

  app.User = Backbone.Model.extend({
    parse: function(response) {
      return response.user;
    },
    urlRoot: myConfig.domain + "/api/users"
  });

  app.user = new app.User;


  /* keep the destination cateogry of the uploding itme */

  app.Category = Backbone.Model.extend({
    parse: function(resp, opt) {
      if (opt.collection) {
        return resp;
      } else {
        return resp.category;
      }
    }
  });

  app.destination = null;

  app.Categories = Backbone.Collection.extend({
    model: app.Category,
    url: myConfig.domain + "/api/categories",
    parse: function(resp) {
      return resp.categories;
    }
  });

  app.categories = new app.Categories();


  /* view for each element of dropdown menu */

  app.CategoryView = Backbone.View.extend({
    tagName: "li",
    className: "small",
    initialize: function() {
      return this.$el.html($("<a>").text(this.model.get("name")));
    },
    events: {
      "click a": function() {
        return app.storage.update({
          destination: this.model.toJSON()
        });
      }
    }
  });


  /* dropdown categories view */

  app.CategoriesView = Backbone.View.extend({
    initialize: function() {
      this.template = _.template($("#categoriesDropdown-t").html());
      this.putListeners();
      app.categories.fetch({
        data: {
          user_id: app.storage.getData().session.id
        }
      });
      app.destination = app.storage.getData().destination ? app.storage.getData().destination : void 0;
      return this.render();
    },
    putListeners: function() {
      app.categories.on("sync", (function(_this) {
        return function() {
          return _this.render();
        };
      })(this));
      return app.storage.on("update", (function(_this) {
        return function(data) {
          app.destination = data.destination;
          _this.render();
          return _this.resetContentScriptsApp();
        };
      })(this));
    },
    render: function() {
      this.$el.html(this.template({
        title: app.destination ? app.destination.name : "--- Choose Category ---"
      }));
      this.initDropdown();
      return this.initPopover();
    },
    initDropdown: function() {
      app.categories.each(function(category) {
        return this.$(".dropdown-menu").append(new app.CategoryView({
          model: category
        }).$el);
      });
      return this.$('.dropdown-toggle').dropdown();
    },
    initPopover: function() {
      return this.$("#new-category").popover({
        content: _.template($("#new-category-popover-content-t").html())({})
      });
    },
    events: {
      "keypress #new-category-name": "newCategory"
    },
    newCategory: function(e) {
      var name, newCat;
      name = this.$("#new-category-name").val();
      if (e.which === 13 && name !== "") {
        newCat = app.categories.create({
          name: name
        }, {
          headers: {
            Authorization: app.storage.getData().session.auth_token
          }
        });
        return app.storage.update({
          destination: newCat.toJSON()
        });
      }
    },
    resetContentScriptsApp: function() {
      return chrome.tabs.query({
        active: true,
        currentWindow: true
      }, function(tabs) {
        return chrome.tabs.sendMessage(tabs[0].id, {
          type: "popup#appReset"
        });
      });
    }
  });


  /* after authentication */

  app.AuthedView = Backbone.View.extend({
    initialize: function() {
      this.$el.html(_.template($("#authedView-t").html())({
        user: this.model.toJSON()
      }));
      return app.categoriesView = new app.CategoriesView({
        el: this.$("#categoriesDropdown")
      });
    },
    events: {
      "click #on": function(e) {
        return chrome.tabs.query({
          active: true,
          currentWindow: true
        }, function(tabs) {
          return chrome.tabs.sendMessage(tabs[0].id, {
            type: "popup#appOn"
          });
        });
      },
      "click #off": function(e) {
        return chrome.tabs.query({
          active: true,
          currentWindow: true
        }, function(tabs) {
          return chrome.tabs.sendMessage(tabs[0].id, {
            type: "popup#appOff"
          });
        });
      },
      "click #logout": function(e) {
        return app.storage.clear();
      }
    }
  });


  /* before authentication */

  app.LoginView = Backbone.View.extend({
    initialize: function() {
      return this.$el.html(_.template($("#loginView-t").html())({}));
    },
    events: {
      "submit #loginForm": function(e) {
        e.preventDefault();
        return Promise.resolve($.ajax({
          url: myConfig.domain + "/api/sessions",
          type: "POST",
          data: this.$("#loginForm").serialize()
        })).then((function(_this) {
          return function(data) {
            return app.storage.update({
              session: data
            });
          };
        })(this))["catch"]((function(_this) {
          return function(err) {
            return app.mainView.renderFlashMessage("Error happend. Try again.");
          };
        })(this));
      },
      "click #register": function(e) {
        return extLib.createTab(myConfig.domain + "/#/register");
      }
    }
  });


  /* main view */

  app.MainView = Backbone.View.extend({
    initialize: function() {
      $("#flash").hide();
      this.putListeners();
      return app.storage.init();
    },
    putListeners: function() {
      app.storage.on("update", (function(_this) {
        return function(data) {
          if ((data != null) && (data.session != null) && (data.session.id != null) && (data.session.auth_token != null)) {
            return app.user.set({
              id: data.session.id
            }).fetch({
              headers: {
                Authorization: data.session.auth_token
              }
            });
          } else {
            _this.renderFlashMessage("You need to login.");
            return _this.renderLoginView();
          }
        };
      })(this));
      app.user.on("sync", (function(_this) {
        return function() {
          $("#flash").hide();
          return _this.renderAuthedView(app.user);
        };
      })(this));
      return app.user.on("error", (function(_this) {
        return function() {
          _this.renderFlashMessage("Error happened. Try to login again.");
          return _this.renderLoginView();
        };
      })(this));
    },
    renderLoginView: function() {
      return this.$el.html(new app.LoginView().$el);
    },
    renderAuthedView: function(user) {
      return this.$el.html(new app.AuthedView({
        model: user
      }).$el);
    },
    renderFlashMessage: function(message) {
      return $("#flash").text(message).show();
    }
  });

  app.mainView = null;

  $(function() {
    return app.mainView = new app.MainView({
      el: $("#main")
    });
  });

}).call(this);
