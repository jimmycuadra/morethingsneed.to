class MTNT.Views.AddEntry extends Backbone.View
  tagName: "form"

  className: "form-inline centered"

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
      success: =>
        MTNT.app.flash.success("Your entry was added.")
        @el.reset()
      error: (model, errors) =>
        MTNT.app.flash.error("Your entry could not be added.", errors)

  toBoolean: (value) ->
    !!parseInt(value, 10)
