#= require jquery_ujs
#= require underscore
#= require backbone
#= require hamlcoffee
#= require_self
#= require_tree ./templates

window.MTNT =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    $("#main").html(MTNT.JST["navbar"]())

$(MTNT.init)
