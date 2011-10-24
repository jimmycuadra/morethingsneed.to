#= require underscore
#= require backbone
#= require_self
#= require_tree ./

window.MTNT =
  Collections: {}
  Models: {}
  Routers: {}
  Views: {}
  Instances: {}
  init: (data) ->
    @Instances.entries = new @Views.Entries data
