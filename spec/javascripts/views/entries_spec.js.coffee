describe "MTNT.Views.Entries", ->
  describe "#initialize", ->
    beforeEach ->
      @entries = new MTNT.Views.Entries [new Backbone.Model, new Backbone.Model, new Backbone.Model]

    it "instantiates an entry collection", ->
      expect(@entries.collection instanceof MTNT.Collections.Entries).toBeTruthy()

    it "populates the collection with data", ->
      expect(@entries.collection.length).toEqual 3
