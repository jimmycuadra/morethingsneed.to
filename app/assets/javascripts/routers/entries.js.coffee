class MTNT.Routers.Entries extends Backbone.Router
  routes:
    "": "index"
    "entries/:id": "show"

  index: ->
    entries = new MTNT.Views.Entries(collection: MTNT.app.collection)
    MTNT.app.$content.html(entries.render().el)

  show: (id) ->
    console.log("Show entry #{id}")
