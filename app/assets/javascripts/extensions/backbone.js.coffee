originalRemove = Backbone.View::remove

Backbone.View::bindTo = (object, args...) ->
  @_bindings ||= []
  @_bindings.push(object: object, args: args)
  object.on.apply(object, args)

Backbone.View::remove = ->
  if @_bindings
    for binding in @_bindings
      binding.object.off.apply(binding.args)
  originalRemove.call(this)
