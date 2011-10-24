class MTNT.Views.Entry extends Backbone.View
  initialize: (model) ->
    @model = model

  tagName: "article"

  template: JST["templates/entry"]

  render: ->
    ($ @el).html @template(@model.toJSON())
    this
