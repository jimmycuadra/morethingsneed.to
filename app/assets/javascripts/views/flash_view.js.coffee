class mtnt.views.FlashView extends Backbone.View
  className: "alert"

  template: JST.flash

  initialize: ->
    if (type = @model.get("type"))
      @$el.addClass("alert-#{type}")

  fadeOut: ->
    @$el.fadeOut(@remove.bind(this))

  render: ->
    @$el.html(@template(@model.toJSON()))
    this
