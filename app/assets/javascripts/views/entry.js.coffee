class EntryView extends Backbone.View
  tagName: "article"

  template: JST["templates/entry"]

  render: ->
    ($ @el).html @template(@model.toJSON())
    this

Extractor.exports "EntryView", EntryView
