class mtnt.views.EntryView extends Backbone.View
  tagName: "article"

  className: "entry"

  template: JST.entry

  initialize: ->
    @model.on("change", @render, this)

  render: ->
    @$el.html(@template(@model.toJSON()))
    this
