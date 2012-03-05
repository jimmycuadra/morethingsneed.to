#= require jquery_ujs
#= require underscore
#= require backbone
#= require hamlcoffee
#= require_self
#= require_tree ./templates
#= require_tree ./

window.MTNT =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    @app = new @Routers.ApplicationRouter
    Backbone.history.start(pushState: true)

$ ->
  MTNT.init()
