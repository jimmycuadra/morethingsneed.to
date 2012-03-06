class MTNT.Views.Entries extends Backbone.View
  tagName: "section"

  id: "entries"

  initialize: ->
    @collection.on("add", @render, this)
    @collection.on("remove", @render, this)
    @collection.on("reset", @render, this)

  render: ->
    @$el.empty()
    @collection.each (entry) =>
      view = new MTNT.Views.Entry(model: entry)
      @$el.append(view.render().el)
    this
