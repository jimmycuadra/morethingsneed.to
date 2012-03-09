class MTNT.Models.Entry extends Backbone.Model
  validate: (attributes) ->
    errors = {}
    errors.noun = "required" unless attributes.noun.length
    errors.verb = "required" unless attributes.verb.length
    return errors if _.keys(errors).length
