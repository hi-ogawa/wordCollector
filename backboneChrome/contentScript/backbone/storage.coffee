# wrapper chrome storage API by extending Backbone.Model
# ex.
# 
#  # init and load the previous data
#  storage = new MyStorage()
#  storage.init()
# 
#  # store any objects
#  storage.update {key: "value"}
#
#  # get stored data (of the current moment)
#  storage.getData().key
#   
#  # get stored data (via promise)
#  storage.get().then (data) -> console.log data.key
# 
#  # delete all stored data
#  storage.clear()
#
#  # listen to the completion of `storage.update`, `storage.init` or `storage.delete`
#  storage.on "update", => doSomething(storage)

MyStorage = Backbone.Model.extend
  initialize: -> @items = {}

  init: ->
    chrome.storage.sync.get (items) =>
      _(@items).extend items
      @trigger "update", @items

  getData: -> @items

  clear: ->
    chrome.storage.sync.clear =>
      @items = {}
      @trigger "update", @items
    
  update: (items) ->
    new Promise (resolve, reject) =>
      chrome.storage.sync.set items, =>
        _(@items).extend items
        @trigger "update", @items
        resolve @items
      setTimeout(( -> reject "lib.storageSet timeout"), 1000)

root = exports ? this
root.MyStorage = MyStorage
