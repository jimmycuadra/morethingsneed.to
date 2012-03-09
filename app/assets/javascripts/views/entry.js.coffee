class MTNT.Views.Entry extends Backbone.View
  tagName: "article"

  className: "entry"

  template: MTNT.JST["entry"]

  render: ->
    @$el.html(@template(@model.toJSON()))
    this
