class mtnt.views.EntryView extends Backbone.View
  template: JST.entry

  render: ->
    @$el.html(@template(@model.toJSON()))
    this
