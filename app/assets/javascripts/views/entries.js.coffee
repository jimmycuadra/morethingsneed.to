class MTNT.Views.Entries extends Backbone.View
  el: $("#entries")

  initialize: ->
    @bindTo(@collection, "add", @addOne, this)
    @bindTo(@collection, "reset", @addAll, this)

  addOne: (entry) =>
    view = new MTNT.Views.Entry(model: entry)
    @$el.prepend(view.render().el)

  addAll: ->
    @$el.empty()
    @collection.each(@addOne)
