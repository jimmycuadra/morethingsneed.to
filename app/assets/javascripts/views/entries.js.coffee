class MTNT.Views.Entries extends Backbone.View
  initialize: ->
    @collection = new MTNT.Collections.Entries
    @collection.bind "add", @addOne
    @collection.bind "reset", @addAll

  el: $("#entries")

  addOne: (entry) =>
    view = new MTNT.Views.Entry(model: entry)
    @el.append view.render().el

  addAll: =>
    @collection.each @addOne
