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
  constructor: ->
    @content = $("#content")

  display: (view, title, activeTab) ->
    @page.remove() if @page and @page.remove
    @page = view
    @page.render() if @page.render
    @content.html(@page.el || @page)
    document.title = "#{title} | More Things Need To"
    @view.refreshNavbar(activeTab)

$ ->
  mtnt.app = new mtnt.Application

  mtnt.app.session = new mtnt.models.Session
  mtnt.app.view = new mtnt.views.ApplicationView
  mtnt.app.router = new mtnt.routers.ApplicationRouter

  Backbone.history.start(pushState: true)
