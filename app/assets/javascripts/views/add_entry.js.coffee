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
      needs: @toBoolean(@$("[name=needs]").val())

    @collection.create attributes,
      wait: true,
      error: @showErrors

  showErrors: (model, errors) ->
    console.log(arguments)

  toBoolean: (value) ->
    !!parseInt(value, 10)
