class MTNT.Models.Entry extends Backbone.Model
  validate: (attributes) ->
    errors = {}

    for key, value of attributes when !value.length
      errors[key] = "required"

    return errors if _.keys(errors).length
