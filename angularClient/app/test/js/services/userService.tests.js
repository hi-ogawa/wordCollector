// Generated by CoffeeScript 1.9.3
(function() {
  describe("UserService", function() {
    var $httpBackend, $resource, AuthService, UserService, createArg, createPayload, response, updateArg, updatePayload;
    UserService = AuthService = $resource = $httpBackend = null;
    createArg = updateArg = {
      email: "johndoe@john",
      password: "12345678",
      password_confirmation: "12345678"
    };
    createPayload = updatePayload = {
      user: createArg
    };
    response = {
      user: {
        id: 1,
        email: "johndoe@john",
        auth_token: "sP3hoKN5-y-tRtagTf2B",
        created_at: "2015-08-09T06:00:37.484Z",
        updated_at: "2015-08-09T06:00:37.484Z",
        category_ids: []
      }
    };
    beforeEach(module("app"));
    beforeEach(module(function($provide) {
      AuthService = {
        getSession: function() {
          return {
            userId: 1,
            token: "sP3hoKN5-y-tRtagTf2B"
          };
        }
      };
      $provide.value("AuthService", AuthService);
    }));
    beforeEach(inject(function(_UserService_, _$resource_, _$httpBackend_) {
      var ref;
      return ref = [_UserService_, _$resource_, _$httpBackend_], UserService = ref[0], $resource = ref[1], $httpBackend = ref[2], ref;
    }));
    afterEach(function() {
      $httpBackend.verifyNoOutstandingExpectation();
      return $httpBackend.verifyNoOutstandingRequest();
    });
    describe(".show", function() {
      return it("", function() {
        $httpBackend.expectGET("/api/users/1", void 0, function(headers) {
          return headers["Authorization"] === "sP3hoKN5-y-tRtagTf2B";
        }).respond(response);
        UserService.show();
        return $httpBackend.flush();
      });
    });
    describe(".create", function() {
      return it("", function() {
        $httpBackend.expectPOST("/api/users", createPayload).respond(response);
        UserService.create(createArg);
        return $httpBackend.flush();
      });
    });
    describe(".update", function() {
      return it("", function() {
        $httpBackend.expectPUT("/api/users/1", updatePayload, function(headers) {
          return headers["Authorization"] === "sP3hoKN5-y-tRtagTf2B";
        }).respond(response);
        UserService.update(createArg);
        return $httpBackend.flush();
      });
    });
    return describe(".delete", function() {
      return it("", function() {
        $httpBackend.expectDELETE("/api/users/1", void 0, function(headers) {
          return headers["Authorization"] === "sP3hoKN5-y-tRtagTf2B";
        }).respond(response);
        UserService.destroy();
        return $httpBackend.flush();
      });
    });
  });

}).call(this);
