#= require extractor
#= require underscore
#= require backbone
#= require_self
#= require_tree ./

window.MTNT =
  exports: Extractor.exports
  require: Extractor.require
  init: (data) ->
    EntriesView = @require "views/entries"
    @entries = new EntriesView
    @entries.collection.reset data
