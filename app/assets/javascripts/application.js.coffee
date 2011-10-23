#= require underscore
#= require backbone
#= require_self
#= require models/entry

window.MTNT =
  Collections: {}
  Models: {}
  Routers: {}
  Views: {}
  Instances: {}
  init: (entries) ->
    @Instances.entries = new @Collections.Entries entries
