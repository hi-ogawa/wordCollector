// Generated by CoffeeScript 1.9.3
(function() {
  var run;

  run = function($httpBackend) {
    var mockResponse, users;
    $httpBackend.whenGET(/templates\//).passThrough();
    users = [];
    mockResponse = function(email) {
      return {
        id: 1,
        email: email,
        auth_token: "sP3hoKN5-y-tRtagTf2B",
        created_at: "2015-08-09T06:00:37.484Z",
        updated_at: "2015-08-09T06:00:37.484Z",
        category_ids: []
      };
    };
    return $httpBackend.whenPOST('/api/users').respond(function(method, url, data) {
      var user;
      user = angular.fromJson(data);
      console.log("-- mock backend --");
      console.log(user);
      users.push(user);
      return [201, mockResponse(user.email)];
    });
  };

  run.$inject = ["$httpBackend"];

  angular.module("app").run(run);

}).call(this);
