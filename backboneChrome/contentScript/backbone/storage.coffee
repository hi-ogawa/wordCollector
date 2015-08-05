# overwapping chrome storage API by extending Backbone.Model
MyStorage = Backbone.Model.extend
  initialize: -> @items = {}
  fetch: -> @get()

  update: (items) ->
    new Promise (resolve, reject) =>
      chrome.storage.sync.set items, =>
        _(@items).extend items
        @trigger "update", @items
        resolve @items
      setTimeout(( -> reject "lib.storageSet timeout"), 1000)

  get: ->
    new Promise (resolve, reject) =>
      chrome.storage.sync.get (items) => _(@items).extend items; resolve items
      setTimeout(( -> reject "lib.storageGet timeout"), 1000)

root = exports ? this
root.MyStorage = MyStorage
