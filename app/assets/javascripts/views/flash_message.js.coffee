class MTNT.Views.FlashMessage extends Backbone.View
  className: "alert"

  template: MTNT.JST["flash_message"]

  initialize: (@message, @type, @errors) ->

  render: ->
    switch @type
      when "success"
        @$el.addClass("alert-success")
      when "error"
        @$el.addClass("alert-error")
      when "info"
        @$el.addClass("alert-info")

    @$el.html(@template({ message: @message, errors: @errors }))

    this
