class mtnt.views.EntriesView extends Backbone.View
  initialize: ->
    @listenTo(@collection, "add", @add)

  attach: ->
    @$(".entry").each (index, element) =>
      id = $(element).data("entry-id")
      model = @collection.get(id)
      model.view = new mtnt.views.EntryView
        el: element
        model: model

  add: (entry) ->
    entryView = new mtnt.views.EntryView(model: entry)
    entry.view = entryView
    @$el.prepend(entryView.render().el)
