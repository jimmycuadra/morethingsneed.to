#= require extractor
#= require underscore
#= require backbone
#= require_self
#= require_tree ./

window.MTNT =
  init: (data) ->
    EntriesView = Extractor.require "EntriesView"
    @entries = new EntriesView
    @entries.collection.reset data
