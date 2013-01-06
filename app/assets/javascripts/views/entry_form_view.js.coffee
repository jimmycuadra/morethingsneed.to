class mtnt.views.EntryFormView extends Backbone.View
  initialize: ->
    @setElement($("#new_entry"))
    @listenTo(@model, "error", @displayErrors)

  events:
    submit: "submit"

  submit: (event) =>
    event.preventDefault()

    @model.save(@serializeAttributes())

  serializeAttributes: ->
    {
      noun: @$("#entry_noun").val()
      needs: @$("#entry_needs").val()
      verb: @$("#entry_verb").val()
    }

  displayErrors: (entry, xhr) ->
    errors = JSON.parse(xhr.responseText)
    mtnt.app.flash(errors, "error")
