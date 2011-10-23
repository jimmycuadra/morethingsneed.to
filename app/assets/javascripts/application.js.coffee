#= require underscore
#= require backbone
#= require_self
#= require models/entry

window.MTNT =
  Collections: {}
  Models: {}
  Routers: {}
  Views: {}
  init: (entries) ->
    console.log entries
