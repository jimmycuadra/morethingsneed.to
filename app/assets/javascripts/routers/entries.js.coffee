class MTNT.Routers.Entries extends Backbone.Router
  routes:
    "": "index"
    "entries": "redirect-index"
    "entries/:id": "show"

  index: ->
    view = new MTNT.Views.Entries(collection: MTNT.app.collection)
    MTNT.app.display(view)

  show: (id) ->
    model = MTNT.app.collection.get(id)
    view = new MTNT.Views.Entry(model: model)
    MTNT.app.display(view)

  "redirect-index": ->
    @navigate("", trigger: true, replace: true)
