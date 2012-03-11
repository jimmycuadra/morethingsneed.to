#= require jquery_ujs
#= require jquery.timeago
#= require underscore
#= require backbone
#= require hamlcoffee
#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./routers

window.MTNT =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    @app = {}

    @app.$content = $("#content")

    # Router
    @app.entriesRouter = new @Routers.Entries

    # Collection
    @app.collection = new @Collections.Entries

    # Navbar
    @app.navbar = new MTNT.Views.Navbar
    @app.navbar.render()

    # Add entry form
    @app.addEntry = new MTNT.Views.AddEntry(collection: @collection)
    @app.addEntry.render()

    # Flash messages
    @app.flash = new MTNT.Views.FlashMessages

    # Start history
    Backbone.history.start(pushState: true)

$ ->
  MTNT.init()
