class mtnt.views.EntriesView extends mtnt.views.BaseView
  id: "#entries"

  title: "Entries"

  initialize: ->
    @collection.on("add", @addOne)
    @collection.on("reset", @addAll)

  render: ->
    @addAll()
    this

  addOne: (entry) =>
    view = new mtnt.views.EntryView(model: entry)
    @$el.prepend(view.render().el)

  addAll: =>
    @collection.each(@addOne)
