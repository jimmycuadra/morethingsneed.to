class mtnt.views.LoginView extends mtnt.views.BaseView
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
    mtnt.app.session.logIn()

  clickLogOut: (event) =>
    event.preventDefault()
    mtnt.app.session.logOut()
