describe "MTNT.Views.Entries", ->
  beforeEach ->
    @entries = new MTNT.Views.Entries

  describe "#initialize", ->
    it "instantiates an entry collection", ->
      expect(@entries.collection instanceof MTNT.Collections.Entries).toBeTruthy()

  describe "#addAll", ->
    it "is called when the collection is reset", ->
      spyOn(@entries, "addAll")
      @entries.collection.reset
      expect(@entries.addAll).toHaveBeenCalled()
