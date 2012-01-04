class MTNT.EntriesView extends Backbone.View
  initialize: ->
    @collection = new MTNT.Entries
    @collection.bind "add", @addOne
    @collection.bind "reset", @addAll

  el: $("#entries")

  addOne: (entry) =>
    view = new MTNT.EntryView(model: entry)
    @el.append view.render().el

  addAll: =>
    @collection.each @addOne
