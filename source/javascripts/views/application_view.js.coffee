class mtnt.views.ApplicationView extends Backbone.View
  el: "body"

  events:
    "click .route-entries": "routeEntries"
    "click .route-users": "routeUsers"
    "click .route-settings": "routeSettings"

  initialize: ->
    @nav = $(".nav li")
    @loginView = new mtnt.views.LoginView
    @loginView.render()

  routeEntries: (event) ->
    event.preventDefault()
    mtnt.app.router.navigate("", trigger: true)

  routeUsers: (event) ->
    event.preventDefault()
    mtnt.app.router.navigate("users", trigger: true)

  routeSettings: (event) ->
    event.preventDefault()
    mtnt.app.router.navigate("settings", trigger: true)
