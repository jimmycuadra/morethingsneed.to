class MTNT.Views.Navbar extends Backbone.View
  template: MTNT.JST["navbar"]

  className: "navbar"

  render: ->
    @$el.html(@template())
    $("body").prepend(@$el)
    this
