class mtnt.routers.ApplicationRouter extends Backbone.Router
  routes:
    "": "entries"

  initialize: ->
    sessionData = mtnt.store("session")

    mtnt.session = if sessionData?.api_key
      new mtnt.models.Session(sessionData)
    else
      new mtnt.models.Session

    @loginView = new mtnt.views.LoginView
    @loginView.render()
