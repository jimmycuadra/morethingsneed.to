class MTNT.Views.Entries extends Backbone.View
  tagName: "section"

  id: "entries"

  initialize: ->
    @collection.on("add", @addOne, this)
    @collection.on("reset", @addAll, this)

  addOne: (entry) =>
    view = new MTNT.Views.Entry(model: entry)
    @$el.prepend(view.render().el)

  addAll: ->
    @collection.each(@addOne)
