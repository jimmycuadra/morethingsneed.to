class mtnt.views.EntryView extends mtnt.views.BaseView
  tagName: "article"

  className: "entry"

  template: JST.entry

  title: ->
    "Entry ##{@model.get("id")}"

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
