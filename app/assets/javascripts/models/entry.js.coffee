class MTNT.Models.Entry extends Backbone.Model
  validate: (attributes) ->
    errors = {}
    errors.noun = "noun phrase cannot be blank" unless attributes.noun
    return errors if _.keys(errors).length
