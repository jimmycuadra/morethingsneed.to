class MTNT.Views.Entry extends Backbone.View
  tagName: "article"

  className: "entry"

  template: MTNT.JST["entry"]

  events:
    "click .comment-link": "showAction"

  render: ->
    @$el.html(@template(@model.toJSON()))
    this

  showAction: (evt) ->
    evt.preventDefault()

    MTNT.app.entriesRouter.navigate("entries/#{@model.get('id')}", trigger: true)
