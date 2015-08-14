ItemController = (ItemService, CategoryService, FlashService, $location, $routeParams) ->
  vm = @
  vm.flash = FlashService
  vm.category = CategoryService.show(id: $routeParams.categoryId)
  vm.items = ItemService.index()
  vm.itemOnCursor = ""

  # init magnific-popup library
  vm.initMagnificPopup = ->
    $(".magnific-popup-img").magnificPopup
                               type: 'image'
                               closeOnContentClick: true
                               zoom: {enabled: true, duration: 300}
                               image: {verticalFit: true}
    return

  # sync two scrollable divs
  speed0 = 700 # pixel per second
  vm.scrollPictures = (item) ->
    vm.itemOnCursor = item.id 
    # need to wait a moment for ng-class to apply .onCursor
    setTimeout ->
      # bit tricky to achieve fixed animation speed (which is not necessary)
      picOnTop     = $("#image-popups img").first()
      picOnCursor  = $("#image-popups .onCursor")
      picOffset    = picOnCursor.position().top - picOnTop.position().top
      scrollOffset = picOffset - $("#image-popups").height() / 2 + picOnCursor.height() / 2
      diff         = Math.abs(scrollOffset - $("#image-popups").scrollTop())
      $("#image-popups").animate
        scrollTop: scrollOffset 
        , {duration: (diff/speed0) * 1000, easing: "linear", queue: false}
    , 10
    return
  speed1 = 350
  vm.scrollItems = (item) ->
    vm.itemOnCursor = item.id 
    setTimeout ->
      itemOnTop     = $("#items-list").children().first()
      itemOnCursor  = $("#items-list .onCursor")
      itemOffset    = itemOnCursor.position().top - itemOnTop.position().top
      scrollOffset  = itemOffset - $("#items-list").height() / 2 + itemOnCursor.height() / 2
      diff          = Math.abs(scrollOffset - $("#items-list").scrollTop())
      $("#items-list").animate
        scrollTop: scrollOffset 
        , {duration: (diff/speed1) * 1000, easing: "linear", queue: false}
    , 10
    return

  # prepare form
  vm.showForm = (item) ->
    vm.editing = !!item
    vm.formOn = true
    vm.itemForm = _.clone _(item || {}).extend
      category:
        id: $routeParams.categoryId

  vm.submit = ->
    vm.dataLoading = true
    p =
      if vm.editing then ItemService.update vm.itemForm
      else               ItemService.create vm.itemForm
    p.$promise
    .then ->
      FlashService.set("Successfully Submitted", "success")
      vm.dataLoading = false
      FlashService.apply()
      vm.formOn = false
    ,->
      FlashService.set("Submit failed", "danger")
      vm.dataLoading = false
      FlashService.apply()
      vm.formOn = false

  vm.deleteItem = (item) ->
    ItemService.destroy item

  return
ItemController.$inject = [
  "ItemService", "CategoryService", "FlashService", "$location", "$routeParams"
]
angular.module("app")
       .controller "ItemController", ItemController
