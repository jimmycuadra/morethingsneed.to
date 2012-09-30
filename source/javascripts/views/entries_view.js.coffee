class mtnt.views.EntriesView extends Backbone.View
  id: "#entries"

  initialize: ->
    @collection.on("add", @addOne)
    @collection.on("reset", @addAll)

  addOne: (entry) =>
    view = new mtnt.views.EntryView(model: entry)
    @$el.prepend(view.render().el)

  addAll: =>
    @collection.each(@addOne)
