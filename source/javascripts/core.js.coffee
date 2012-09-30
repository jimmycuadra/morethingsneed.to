# Application's global object.
window.mtnt =
  models: {}

  collections: {}

  views: {}

  routers: {}

  store: amplify.store

  loadAuth: (cb) ->
    @session = new @models.Session

    data = @store("session")
    if data?
      @session.set(data)

    cb() if _.isFunction(cb)

  logIn: (session, cb) ->
    @store("session", session.toJSON())
    @loadAuth(cb)

  logOut: (cb) ->
    @store("session", null)
    @loadAuth(cb)

# Use CORS to communicate with the API.
API_URL = if document.location.hostname is "localhost"
  "http://localhost:3000"
else
  "https://mtnt-api.herokuapp.com"

$.ajaxPrefilter (options, originalOptions, jqXHR) ->
  options.url = API_URL + options.url
  return # Returns undefined to avoid accidental dataType change.
