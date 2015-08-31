// Generated by CoffeeScript 1.9.3
(function() {
  var app, root;

  app = {};

  app.storage = new MyStorage();

  app.session = null;

  app.destination = null;

  app.DictionaryView = Backbone.View.extend({
    tagName: "div",
    initialize: function(data) {
      this.template = _.template($("#ext-dictionary-t").html());
      return this.$el.html(this.template({
        data: data
      }));
    },
    renderData: function(data) {
      var finalHeight;
      this.$el.html(this.template({
        data: data
      }));
      if (data.type === "error") {
        return;
      }
      console.log(data);
      this.$popovers = this.$('[data-toggle="popover"]');
      this.initPopover();
      finalHeight = this.$el.height();
      this.$el.css("height", "20px");
      return this.$el.animate({
        "height": finalHeight
      }, "slow");
    },
    events: {
      "click .remove": "remove",
      "mouseleave": function() {
        return this.$popovers.popover('hide');
      },
      "mouseover [data-toggle='popover']": function(e) {
        return $(e.currentTarget).popover('show');
      },
      "show.bs.popover [data-toggle='popover']": function(e) {
        return this.$popovers.not($(e.currentTarget)).popover('hide');
      },
      "click .suggestion": function(e) {
        app.appView.$("#ext-word").val($(e.currentTarget).text());
        return app.appView.renderDictionaries();
      }
    },
    initPopover: function() {
      return this.$popovers.each(function() {
        var $popoverContent;
        $popoverContent = $(this).next().remove();
        $popoverContent.find(".meaning").click(function() {
          return app.appView.$("#ext-meaning").val($(this).text());
        });
        return $(this).popover({
          content: $popoverContent
        });
      });
    }
  });

  app.AppView = Backbone.View.extend({
    initialize: function() {
      this.$el.html(_.template($("#ext-content-t").html())({}));
      this.$('[data-toggle="tooltip"]').tooltip();
      this.changeUploadIcons("wait");
      app.storage.init();
      app.storage.on("update", (function(_this) {
        return function(data) {
          app.session = data.session;
          return app.destination = data.destination;
        };
      })(this));
      return $('body').dblclick((function(_this) {
        return function(e) {
          var s, w;
          w = window.getSelection().toString().trim();
          s = window.getSelection().getRangeAt(0).startContainer.parentNode.textContent.trim();
          _this.$("#ext-word").val((_this.$("#ext-word").val() + " " + w).trim()).focus();
          _this.$("#ext-sentence").val(s);
          return _this.renderDictionaries();
        };
      })(this));
    },
    events: {
      "keypress #ext-word": function(e) {
        if (e.which === 13) {
          e.preventDefault();
          return this.renderDictionaries();
        }
      },
      "submit #upload": function(e) {
        e.preventDefault();
        return this.upload();
      }
    },
    renderDictionaries: function() {
      var word;
      word = this.$("#ext-word").val().trim();
      if (word !== "") {
        this.renderEijiro(word);
        return this.renderMarriam(word);
      }
    },
    renderEijiro: function(word) {
      if (this.eijiroView != null) {
        this.eijiroView.remove();
      }
      this.eijiroView = new app.DictionaryView({
        dictionary: "Eijiro",
        type: "",
        loading: true
      });
      this.$("#ext-dictionaries").append(this.eijiroView.$el);
      return extLib.Eijiro(word).then((function(_this) {
        return function(data) {
          return _this.eijiroView.renderData(data);
        };
      })(this))["catch"]((function(_this) {
        return function(err) {
          return _this.eijiroView.renderData({
            dictionary: "Eijiro",
            type: "error",
            loading: false
          });
        };
      })(this));
    },
    renderMarriam: function(word) {
      if (this.marriamView != null) {
        this.marriamView.remove();
      }
      this.marriamView = new app.DictionaryView({
        dictionary: "Merriam-Webster",
        type: "",
        loading: true
      });
      this.$("#ext-dictionaries").append(this.marriamView.$el);
      return extLib.DictionaryAPI(word).then((function(_this) {
        return function(data) {
          return _this.marriamView.renderData(data);
        };
      })(this))["catch"]((function(_this) {
        return function(err) {
          return _this.marriamView.renderData({
            dictionary: "Merriam-Webster",
            type: "error",
            loading: false
          });
        };
      })(this));
    },
    upload: function() {
      this.changeUploadIcons("loading");
      return extLib.tabCapture().then((function(_this) {
        return function(dataurl) {
          return chrome.runtime.sendMessage({
            type: "uploadItem",
            category_id: app.destination.id,
            word: _this.$("#ext-word").val(),
            sentence: _this.$("#ext-sentence").val(),
            meaning: _this.$("#ext-meaning").val(),
            picture: dataurl,
            headers: {
              Authorization: app.session.auth_token
            }
          }, function(resp) {
            if (resp.status === "success") {
              return _this.changeUploadIcons("success");
            } else {
              return _this.changeUploadIcons("fail");
            }
          });
        };
      })(this))["catch"]((function(_this) {
        return function(err) {
          _this.changeUploadIcons("fail");
          return console.log(err);
        };
      })(this));
    },
    changeUploadIcons: function(state) {
      return this.$("#upload-icons > *").each(function() {
        return $(this).toggleClass("hide", !($(this).attr("id").match(state)));
      });
    }
  });

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  root.app = app;

}).call(this);
