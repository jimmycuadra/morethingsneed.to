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
    # Router
    @app = new @Routers.Entries

    # Collection
    @app.collection = new @Collections.Entries

    ## DOM elements
    @app.$body = $("body")
    @app.$main = $("#main")

    # Navigation
    navbar = new MTNT.Views.Navbar
    @app.$body.prepend(navbar.render().el)

    # Add entry form
    add_entry = new MTNT.Views.AddEntry(collection: @collection)
    @app.$main.append(add_entry.render().el)

    # Flash messages
    @app.flash = new MTNT.Views.FlashMessages
    @app.$main.append(@app.flash.el)

    # Start history
    Backbone.history.start(pushState: true)

$ ->
  MTNT.init()
