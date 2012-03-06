#= require jquery_ujs
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
    @app = new @Routers.App
    Backbone.history.start(pushState: true)

$ ->
  MTNT.init()
