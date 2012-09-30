class mtnt.models.Session extends Backbone.Model
  urlRoot: "/sessions"

  initialize: ->
    data = mtnt.store("session")
    @set(data) if data?
    @on("sync", @logIn, this)
    navigator.id.watch(onlogin: @verifyAssertion, onlogout: @logOut)

  verifyAssertion: (assertion) =>
    @save({ assertion: assertion })

  logIn: ->
    mtnt.store("session", @toJSON())

  logOut: ->
    @clear()
    mtnt.store("session", null)
