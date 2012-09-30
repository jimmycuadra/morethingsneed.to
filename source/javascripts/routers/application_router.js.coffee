class mtnt.routers.ApplicationRouter extends Backbone.Router
  routes:
    "": "entries"

  initialize: ->
    @loginView = new mtnt.views.LoginView
    @loginView.render()
