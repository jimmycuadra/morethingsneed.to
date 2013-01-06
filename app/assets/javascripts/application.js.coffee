#= require underscore
#= require backbone
#= require core
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views

class mtnt.Application
  start: ->
    @csrfToken = $('meta[name="csrf-token"]').attr('content')
    @entryFormView = new mtnt.views.EntryFormView(model: new mtnt.models.Entry)

$ ->
  mtnt.app = new mtnt.Application
  mtnt.app.start()
