class mtnt.views.LoginView extends Backbone.View
  el: "#persona"

  template: JST.persona

  events:
    "click .log-in": "clickLogIn"
    "click .log-out": "clickLogOut"

  initialize: ->
    mtnt.app.session.on("change", @render, this)

  render: ->
    @$el.html(@template({ session: mtnt.app.session }))
    this

  clickLogIn: (event) ->
    event.preventDefault()
    navigator.id.request(siteName: "More Things Need To")

  clickLogOut: (event) =>
    event.preventDefault()
    mtnt.app.session.logOut()
