describe "MTNT.Views.Entries", ->
  beforeEach ->
    @entries = new MTNT.Views.Entries

  describe "#initialize", ->
    it "instantiates an entry collection", ->
      expect(@entries.collection instanceof MTNT.Collections.Entries).toBeTruthy()

  describe "#addAll", ->
    it "calls #addOne for each model in the collection", ->
      spyOn @entries, "addOne"
      @entries.collection.reset [new Backbone.Model, new Backbone.Model, new Backbone.Model]
      expect(@entries.addOne.callCount).toEqual 3
