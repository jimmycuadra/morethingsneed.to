class MTNT.Views.Entry extends Backbone.View
  tagName: "article"

  className: "entry"

  template: MTNT.JST["entry"]

  events:
    "click .comment-link": "routeShow"

  render: ->
    @$el.html(@template(@model.toJSON()))
    this

  routeShow: (evt) ->
    evt.preventDefault()

    MTNT.app.navigate("entries/#{@model.get('id')}", trigger: true)
