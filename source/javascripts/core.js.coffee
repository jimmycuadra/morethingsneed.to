# Application's global object.
window.mtnt =
  models: {}
  collections: {}
  views: {}
  routers: {}
  store: amplify.store

# Use CORS to communicate with the API.
API_URL = if document.location.hostname is "localhost"
  "http://localhost:3000"
else
  "https://mtnt-api.herokuapp.com"

$.ajaxPrefilter (options, originalOptions, jqXHR) ->
  options.url = API_URL + options.url
  return # Returns undefined to avoid accidental dataType change.
