#= require models/entry
#= require views/entry

Entries = MTNT.require "collections/entries"
Entry = MTNT.require "views/entry"

class EntriesView extends Backbone.View
  initialize: ->
    @collection = new Entries
    @collection.bind "add", @addOne
    @collection.bind "reset", @addAll

  el: $("#entries")

  addOne: (entry) =>
    view = new Entry(model: entry)
    @el.append view.render().el

  addAll: =>
    @collection.each @addOne

MTNT.exports "views/entries", EntriesView
