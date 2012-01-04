#= require_self
#= require underscore
#= require backbone
#= require models/entry
#= require collections/entries
#= require templates/entry
#= require views/entry
#= require views/entries

window.MTNT =
  init: (data) ->
    @entries = new MTNT.EntriesView
    @entries.collection.reset data
