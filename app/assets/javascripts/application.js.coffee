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
    @entryFormView = new mtnt.views.EntryFormView(model: new mtnt.models.Entry)

  flash: (message, type) ->
    if _.isObject(message) and message.errors
      message = @_getErrorMessage(message)

    flash = new mtnt.models.Flash(message: message, type: type)
    flashView = new mtnt.views.FlashView(model: flash)
    $("#flash").prepend(flashView.render().el)
    setTimeout(flashView.fadeOut.bind(flashView), 3000)

$ ->
  mtnt.app = new mtnt.Application
  mtnt.app.start()
  mtnt.app.flash("foo", "error")
