class mtnt.views.EntryFormView extends Backbone.View
  initialize: ->
    @setElement($("#new_entry"))
    @reset()

  events:
    submit: "submit"

  reset: ->
    @el.reset()
    @stopListening(@model) if @model
    @model = new mtnt.models.Entry
    @listenTo(@model, "sync", @addEntry)
    @listenTo(@model, "error", @displayErrors)

  submit: (event) =>
    event.preventDefault()

    @model.save(@serializeAttributes(), wait: true)

  serializeAttributes: ->
    {
      noun: @$("#entry_noun").val()
      needs: @$("#entry_needs").val()
      verb: @$("#entry_verb").val()
    }

  addEntry: (entry) ->
    @reset()
    entryView = new mtnt.views.EntryView(model: entry)
    $("#entries").prepend(entryView.render().el)
    mtnt.app.flash("Entry added!", "success")

  displayErrors: (entry, xhr) ->
    errors = JSON.parse(xhr.responseText)
    mtnt.app.flash(errors, "error")