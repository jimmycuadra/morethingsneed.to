window.mtnt = mtnt =
  models: {}
  collections: {}
  views: {}

$.ajaxSetup
  beforeSend: (xhr, settings) ->
    return if (settings.crossDomain)
    return if (settings.type is "GET")
    xhr.setRequestHeader("X-CSRF-Token", mtnt.app.csrfToken)
