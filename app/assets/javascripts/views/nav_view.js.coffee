class mtnt.views.NavView extends Backbone.View
  events:
    "click .persona-log-in": "login"

  login: (event) ->
    event.preventDefault()
    navigator.id.request()
