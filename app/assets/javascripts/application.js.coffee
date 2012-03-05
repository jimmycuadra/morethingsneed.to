#= require jquery_ujs
#= require underscore
#= require backbone
#= require_tree ./

window.MTNT =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    $("#main").html(JST["templates/navbar"]())

$(MTNT.init)
