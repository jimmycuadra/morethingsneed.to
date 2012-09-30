class mtnt.routers.ApplicationRouter extends Backbone.Router
  routes:
    "": "entries"

  initialize: ->
    @route(/^(\d+)$/, "entry")

  entries: ->
    entries = new mtnt.collections.Entries
    entriesView = new mtnt.views.EntriesView(collection: entries)
    entries.fetch()
    mtnt.app.display(entriesView, "Entries", "entries")

  entry: (id) ->
    mtnt.app.display("Entry #{id}", "Entry #{id}")
