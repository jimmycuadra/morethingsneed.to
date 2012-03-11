class MTNT.Views.Entries extends Backbone.View
  tagName: "section"

  id: "entries"

  initialize: ->
    @bindTo(@collection, "add", @addEntry, this)
    @bindTo(@collection, "reset", @render, this)

  addEntry: (entry) =>
    view = new MTNT.Views.Entry(model: entry)
    @$el.prepend(view.render().el)
    this

  render: ->
    @collection.each(@addEntry)
    this
