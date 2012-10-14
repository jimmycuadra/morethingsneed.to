#= require "vendor/jquery.timeago"
#= require "vendor/amplify.store"
#= require "vendor/underscore"
#= require "vendor/backbone"
#= require "hamlcoffee"
#= require "core"
#= require_tree "./models"
#= require_tree "./collections"
#= require_tree "./templates"
#= require_tree "./views"
#= require_tree "./routers"

class mtnt.Application
  start: ->
    @content = $("#content")
    @session = new mtnt.models.Session
    @appView = new mtnt.views.ApplicationView
    @router = new mtnt.routers.ApplicationRouter
    Backbone.history.start(pushState: true)

  changeView: (view) ->
    @currentView.cleanup() if @currentView
    @currentView = view
    @currentView.render()
    @content.html(@currentView.el)
    document.title = "#{@currentView.title} | More Things Need To"

$ ->
  mtnt.app = new mtnt.Application
  mtnt.app.start()
