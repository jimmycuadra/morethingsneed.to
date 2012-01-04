class MTNT.Entry extends Backbone.Model
  defaults:
    needs: false

  validate: (attributes) ->
    errors = {}

    errors.noun = "noun phrase cannot be blank" unless attributes.noun
    errors.verb = "verb phrase cannot be blank" unless attributes.verb

    return errors if _.keys(errors).length
