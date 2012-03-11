class MTNT.Views.FlashMessages extends Backbone.View
  el: $("#flash")

  success: (message) ->
    flash = new MTNT.Views.FlashMessage(message, "success")
    @attach(flash)

  error: (message, errors) ->
    flash = new MTNT.Views.FlashMessage(message, "error", errors)
    @attach(flash)

  info: (message) ->
    flash = new MTNT.Views.FlashMessage(message, "info")
    @attach(flash)

  notice: (message) ->
    flash = new MTNT.Views.FlashMessage(message)
    @attach(flash)

  attach: (flash) ->
    @$el.prepend(flash.render().el)

    fadeOut = =>
      flash.$el.fadeOut "1500", ->
        flash.remove()

    setTimeout(fadeOut, 4000)
