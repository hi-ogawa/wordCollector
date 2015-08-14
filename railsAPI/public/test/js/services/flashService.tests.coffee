describe "FlashService", ->

  FlashService = $rootScope = null

  beforeEach module "app"
  beforeEach inject (_FlashService_, _$rootScope_) ->
    FlashService =  _FlashService_
    $rootScope   =  _$rootScope_

  describe ".getStatus", ->
    it "returns empty string initially", ->
      expect(FlashService.getStatus()).toBe("")

  describe ".getMessage", ->
    it "returns empty string initially", ->
      expect(FlashService.getMessage()).toBe("")


  describe ".set", ->
    it "needs to run .apply to set the value", ->
      FlashService.set "You got it!", "success"
      expect(FlashService.getStatus()).toBe("")
      expect(FlashService.getMessage()).toBe("")
      FlashService.apply()
      expect(FlashService.getStatus()).toBe("success")
      expect(FlashService.getMessage()).toBe("You got it!")
      FlashService.apply()
      expect(FlashService.getStatus()).toBe("")
      expect(FlashService.getMessage()).toBe("")

    it "route change triggers .apply", ->
      FlashService.set "You got it!", "success"
      expect(FlashService.getStatus()).toBe("")
      expect(FlashService.getMessage()).toBe("")
      $rootScope.$broadcast "$routeChangeSuccess"
      expect(FlashService.getStatus()).toBe("success")
      expect(FlashService.getMessage()).toBe("You got it!")
      $rootScope.$broadcast "$routeChangeSuccess"
      expect(FlashService.getStatus()).toBe("")
      expect(FlashService.getMessage()).toBe("")
