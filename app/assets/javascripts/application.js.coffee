#= require underscore
#= require backbone
#= require hamlcoffee
#= require core
#= require persona
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./templates
#= require_tree ./views

class mtnt.Application
  start: ->
    $newEntry = $("#new_entry")
    if $newEntry.length
      @entryFormView = new mtnt.views.EntryFormView(el: $newEntry)

    $entries = $("#entries")
    if $entries.length
      @entries = new mtnt.collections.Entries(mtnt.data.entries)
      @entriesView = new mtnt.views.EntriesView
        el: $entries
        collection: @entries
      @entriesView.attach()

    @persona = new mtnt.Persona(mtnt.data.person_uid)
    @persona.watch()

    @navView = new mtnt.views.NavView(el: ".navbar")

  flash: (message, type) ->
    flash = new mtnt.models.Flash(message: message, type: type)
    flashView = new mtnt.views.FlashView(model: flash)
    $("#flash").prepend(flashView.render().el)
    setTimeout(flashView.fadeOut.bind(flashView), 3000)

$ ->
  mtnt.csrfToken = $('meta[name="csrf-token"]').attr('content')
  mtnt.app = new mtnt.Application
  mtnt.app.start()
