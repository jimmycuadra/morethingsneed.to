class mtnt.views.EntryFormView extends Backbone.View
  initialize: ->
    @setElement($("#new_entry"))

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
