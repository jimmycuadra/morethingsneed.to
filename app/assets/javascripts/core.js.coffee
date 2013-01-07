window.mtnt = mtnt =
  models: {}
  collections: {}
  views: {}
  data: {}

HAML.globals = ->
  {
    capitalize: (string) ->
      string.charAt(0).toUpperCase() + string.slice(1)
    currentUser: ->
      mtnt.data.current_user
  }

$.ajaxSetup
  beforeSend: (xhr, settings) ->
    return if (settings.crossDomain)
    return if (settings.type is "GET")
    xhr.setRequestHeader("X-CSRF-Token", mtnt.csrfToken)
