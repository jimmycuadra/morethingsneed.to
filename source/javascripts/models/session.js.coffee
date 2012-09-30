class mtnt.models.Session extends Backbone.Model
  urlRoot: "/sessions"

  initialize: ->
    data = mtnt.store("session")
    @set(data) if data?

    navigator.id.watch
      loggedInUser: @get("email")
      onlogin: @verifyAssertion
      onlogout: @clearSession

    @on("sync", @persistSession, this)

  logIn: ->
    navigator.id.request(siteName: "More Things Need To")

  verifyAssertion: (assertion) =>
    @save({ assertion: assertion })

  persistSession: ->
    mtnt.store("session", @toJSON())

  logOut: ->
    navigator.id.logout()

  clearSession: =>
    mtnt.store("session", null)
    @clear()
