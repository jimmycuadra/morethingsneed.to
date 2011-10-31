#= require jquery.timeago

class EntryView extends Backbone.View
  tagName: "article"

  className: "entry"

  template: JST["templates/entry"]

  render: ->
    attributes = @model.toJSON()
    ($ @el).html(@template attributes).find("data").timeago()
    this

MTNT.exports "views/entry", EntryView
