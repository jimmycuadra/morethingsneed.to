class mtnt.views.EntryView extends Backbone.View
  tagName: "article"

  className: "entry"

  template: JST.entry

  initialize: ->
    @model.on("change", @render, this)

  events:
    "click .nav-entry": "navigateEntry"

  render: ->
    @$el.html(@template(@model.toJSON()))
    this

  navigateEntry: (event) ->
    event.preventDefault()
    mtnt.app.router.navigate(@model.get("id").toString(), trigger: true)
