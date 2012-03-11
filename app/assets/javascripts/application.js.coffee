#= require jquery_ujs
#= require jquery.timeago
#= require underscore
#= require backbone
#= require hamlcoffee
#= require_tree ./extensions
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

  Application: class Application
    constructor: ->
      @$content = $("#content")

      # Router
      @entriesRouter = new MTNT.Routers.Entries

      # Collection
      @collection = new MTNT.Collections.Entries
      @collection.fetch()

      # Navbar
      @navbar = new MTNT.Views.Navbar
      @navbar.render()

      # Add entry form
      @addEntry = new MTNT.Views.AddEntry(collection: @collection)
      @addEntry.render()

      # Flash messages
      @flash = new MTNT.Views.FlashMessages

    display: (view) ->
      @currentView.remove() if @currentView
      @currentView = view
      @$content.html(@currentView.render().el)

$ ->
  MTNT.app = new MTNT.Application
  Backbone.history.start(pushState: true)
