class mtnt.views.LoginView extends Backbone.View
  initialize: ->
    @setElement $("#persona")
    @session = new mtnt.models.Session
    navigator.id.watch(onlogin: @createSession, onlogout: @destroySession)

  events:
    "click .persona-button": "clickLogIn"

  clickLogIn: (event) =>
    event.preventDefault()
    navigator.id.request(siteName: "More Things Need To")

  createSession: (assertion) =>
    @session.save({ assertion: assertion }, wait: true, success: @logIn, error: @serverError)

  destroySession: =>
    console.log("destroySession")
    @session.destroy(success: @logOut, error: @serverError)

  logIn: (model, response) ->
    console.log("You're the man now, dog.")

  logOut: (model, response) ->
    console.log("You're no longer the man, dog.")

  serverError: (model, response) ->
    console.log("The server choked.")
