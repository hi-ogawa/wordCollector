// Generated by CoffeeScript 1.9.3
(function() {
  describe('app', function() {
    return it("should redirect to /login", function() {
      browser.get("index.html");
      return expect(browser.getLocationAbsUrl()).toMatch("/login");
    });
  });

}).call(this);