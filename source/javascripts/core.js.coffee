window.mtnt =
  models: {}
  collections: {}
  views: {}
  routers: {}
  store: amplify.store
  logIn: (data, cb) ->
    @store("session", data)
    cb() if _.isFunction(cb)
  logOut: (cb) ->
    @store("session", null)
    cb() if _.isFunction(cb)

API_URL = if document.location.hostname is "localhost"
  "http://localhost:3000"
else
  "https://mtnt-api.herokuapp.com"

originalSync = Backbone.sync
Backbone.sync = (method, model, options) ->
  if not options.url and model.url
    options.url = if _.isFunction(model.url)
      model.url()
    else
      model.url
    options.url = API_URL + options.url

  originalSync.apply(model, [method, model, options])
