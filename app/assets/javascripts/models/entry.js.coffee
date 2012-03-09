class MTNT.Models.Entry extends Backbone.Model
  validate: (attributes) ->
    errors = []

    errors.push("A noun phrase is required.") unless attributes.noun.length
    errors.push("A verb phrase is required.") unless attributes.verb.length

    return errors if errors.length
