class MTNT.Views.Entries extends Backbone.View
  initialize: ->
    @collection = new MTNT.Collections.Entries
    @collection.bind "reset", @addAll

  addAll: =>
    @collection.each @addOne

  addOne: (model) ->
    model.view = new MTNT.Views.Entry model
