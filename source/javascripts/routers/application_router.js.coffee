class mtnt.routers.ApplicationRouter extends Backbone.Router
  routes:
    "": "entries"

  initialize: ->
    @route(/^(\d+)$/, "entry")

  entries: ->
    entriesView = new mtnt.views.EntriesView(collection: mtnt.app.entries)
    mtnt.app.changeView(entriesView)

  entry: (id) ->
    entry = mtnt.app.entries.get(id)
    entryView = new mtnt.views.EntryView(model: entry)
    mtnt.app.changeView(entryView)
