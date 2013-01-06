#= require underscore
#= require backbone
#= require hamlcoffee
#= require core
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./templates
#= require_tree ./views

class mtnt.Application
  start: ->
    @csrfToken = $('meta[name="csrf-token"]').attr('content')
    if $("#new_entry").length
      @entryFormView = new mtnt.views.EntryFormView

  flash: (message, type) ->
    flash = new mtnt.models.Flash(message: message, type: type)
    flashView = new mtnt.views.FlashView(model: flash)
    $("#flash").prepend(flashView.render().el)
    setTimeout(flashView.fadeOut.bind(flashView), 3000)

$ ->
  mtnt.app = new mtnt.Application
  mtnt.app.start()
