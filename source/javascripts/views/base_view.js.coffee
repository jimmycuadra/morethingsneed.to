class mtnt.views.BaseView extends Backbone.View
  cleanup: ->
    @model?.off()
    @collection?.off()
    @remove()
