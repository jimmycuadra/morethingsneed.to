class mtnt.routers.ApplicationRouter extends Backbone.Router
  routes:
    "": "entries"

  initialize: ->
    @loginView = new mtnt.views.LoginView
    @loginView.render()

  entries: ->
    @entries = new mtnt.collections.Entries
    @entriesView = new mtnt.views.EntriesView(collection: @entries)
    @entries.fetch()
