// Generated by CoffeeScript 1.9.3
(function() {
  describe("UserService", function() {
    var $httpBackend, $resource, AuthService, UserService, response, userAttr;
    UserService = AuthService = $resource = $httpBackend = null;
    userAttr = {
      user: {
        email: "johndoe@john",
        password: "12345678",
        password_confirmation: "12345678"
      }
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
            userId: 2,
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
    describe(".create", function() {
      return it("", function() {
        $httpBackend.expectPOST("/api/users", userAttr).respond(function() {
          return [201];
        });
        UserService.create(userAttr);
        return $httpBackend.flush();
      });
    });
    return describe(".update", function() {
      return it("", function() {
        $httpBackend.expectPUT("/api/users/2", userAttr, function(headers) {
          return headers["Authorization"] === "sP3hoKN5-y-tRtagTf2B";
        }).respond(function() {
          return [200];
        });
        UserService.update(userAttr);
        return $httpBackend.flush();
      });
    });
  });

}).call(this);
