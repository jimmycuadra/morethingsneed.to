window.mtnt = mtnt =
  models: {}
  collections: {}
  views: {}

HAML.globals = ->
  {
    capitalize: (string) ->
      string.charAt(0).toUpperCase() + string.slice(1)
  }

$.ajaxSetup
  beforeSend: (xhr, settings) ->
    return if (settings.crossDomain)
    return if (settings.type is "GET")
    xhr.setRequestHeader("X-CSRF-Token", mtnt.app.csrfToken)
