class mtnt.views.LoginView extends Backbone.View
  el: "#persona"

  template: JST.persona

  events:
    "click .persona-button": "clickPersona"
    "click .log-out": "clickLogOut"

  initialize: ->
    navigator.id.watch(onlogin: @createSession, onlogout: @destroySession)

  render: =>
    @$el.html(@template({ session: mtnt.session }))
    this

  clickPersona: (event) =>
    event.preventDefault()
    navigator.id.request(siteName: "More Things Need To")

  clickLogOut: (event) =>
    event.preventDefault()
    @destroySession(@render)

  createSession: (assertion) =>
    mtnt.session.save { assertion: assertion }, wait: true, success: (session, response) =>
      mtnt.logIn(session, @render)

  destroySession: =>
    mtnt.logOut(@render)
