class mtnt.views.EntryView extends Backbone.View
  template: JST["entries/entry"]

  render: ->
    @$el.html(@template(@model.toJSON()))
    this
