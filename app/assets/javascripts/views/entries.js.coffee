class MTNT.Views.Entries extends Backbone.View
  initialize: (entries) ->
    @collection = new MTNT.Collections.Entries
    @collection.reset entries if entries
