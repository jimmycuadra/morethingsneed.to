#= require jquery.timeago

class MTNT.EntryView extends Backbone.View
  tagName: "article"

  className: "entry"

  template: window.JST["templates/entry"]

  render: ->
    $(@el).html(@template(@model.toJSON())).find("data").timeago()
    this
