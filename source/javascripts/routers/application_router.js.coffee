class mtnt.routers.ApplicationRouter extends Backbone.Router
  routes:
    "": "entries"

  entries: ->
    entries = new mtnt.collections.Entries
    entriesView = new mtnt.views.EntriesView(collection: entries)
    entries.fetch()
    mtnt.app.display(entriesView, "Entries")
