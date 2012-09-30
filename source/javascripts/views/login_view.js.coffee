class mtnt.views.LoginView extends Backbone.View
  el: "#persona"

  events:
    "click .persona-button": "clickPersona"

  initialize: ->
    @session = new mtnt.models.Session
    navigator.id.watch(onlogin: @createSession, onlogout: @destroySession)

  render: =>
    console.log("rendering...")
    # $el.html(@template({ session: @session }))
    this

  clickPersona: (event) =>
    event.preventDefault()
    navigator.id.request(siteName: "More Things Need To")

  createSession: (assertion) =>
    @session.save { assertion: assertion }, wait: true, success: (session, response) =>
      mtnt.logIn(response, @render)

  destroySession: =>
    mtnt.logOut(@render)
