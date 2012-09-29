window.mtnt = {
  models: {}
  collections: {}
  views: {}
  routers: {}
  session: amplify.store
}

API_URL = if document.location.hostname is "localhost"
  "http://localhost:3000"
else
  "https://mtnt-api.herokuapp.com"

originalSync = Backbone.sync
Backbone.sync = (method, model, options) ->
  unless options.url
    options.url = if _.isFunction(model.url)
      model.url()
    else
      model.url
    options.url = API_URL + options.url

  originalSync.apply(model, [method, model, options])
