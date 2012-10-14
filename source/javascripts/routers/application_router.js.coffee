class mtnt.routers.ApplicationRouter extends Backbone.Router
  routes:
    "": "entries"

  initialize: ->
    @route(/^(\d+)$/, "entry")

  entries: ->
    entries = new mtnt.collections.Entries
    entriesView = new mtnt.views.EntriesView(collection: entries)
    entries.fetch()
    mtnt.app.changeView(entriesView)

  entry: (id) ->
    # mtnt.app.changeView("Entry #{id}", "Entry #{id}")
