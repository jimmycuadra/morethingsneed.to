class MTNT.Views.AddEntry extends Backbone.View
  tagName: "form"

  className: "form-inline"

  template: MTNT.JST["add_entry"]

  events:
    "submit": "add"

  render: ->
    @$el.html(@template())
    this

  add: (evt) ->
    evt.preventDefault()

    attributes =
      noun: @$("[name=noun]").val()
      verb: @$("[name=verb]").val()
      needs: @$("[name=needs]").val()

    @collection.add(attributes)
