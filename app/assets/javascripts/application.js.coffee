#= require underscore
#= require backbone
#= require_self
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views

window.mtnt = mtnt =
  models: {}
  collections: {}
  views: {}

class mtnt.Application
  start: ->
    @entryFormView = new mtnt.views.EntryFormView(model: new mtnt.models.Entry)

$ ->
  mtnt.app = new mtnt.Application
  mtnt.app.start()
