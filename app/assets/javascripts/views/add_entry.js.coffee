class MTNT.Views.AddEntry extends Backbone.View
  tagName: "form"

  className: "form-inline"

  template: MTNT.JST["add_entry"]

  render: ->
    @$el.html(@template())
    this
