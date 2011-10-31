class EntryView extends Backbone.View
  tagName: "article"

  template: JST["templates/entry"]

  render: ->
    ($ @el).html @template(@model.toJSON())
    this

MTNT.exports "views/entry", EntryView
