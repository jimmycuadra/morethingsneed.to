class EntriesView extends Backbone.View
  initialize: ->
    Entries = Extractor.require "Entries"
    @collection = new Entries
    @collection.bind "add", @addOne
    @collection.bind "reset", @addAll

  el: $("#entries")

  addOne: (entry) =>
    Entry = Extractor.require "EntryView"
    view = new Entry(model: entry)
    @el.append view.render().el

  addAll: =>
    @collection.each @addOne

Extractor.exports "EntriesView", EntriesView
