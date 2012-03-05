class MTNT.Routers.ApplicationRouter extends Backbone.Router
  routes:
    "": "main"

  initialize: ->
    @mainFrame = $("#main")

  main: ->
    @mainFrame.html(MTNT.JST["navbar"]())
