class mtnt.views.BaseView extends Backbone.View
  cleanup: ->
    @model?.off(null, null, this)
    @collection?.off(null, null, this)
    @remove()
