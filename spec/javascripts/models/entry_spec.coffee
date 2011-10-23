describe "MTNT.Models.Entry", ->
  it "has a default 'needs' attribute", ->
    @entry = new MTNT.Models.Entry
    expect(@entry.get "needs").toEqual false

  describe "required attributes", ->
    beforeEach ->
      @entry = new MTNT.Models.Entry
      @entry.collection = { url: "/entries" }
      @spy = jasmine.createSpy "error callback"
      @entry.bind "error", @spy
      @entry.save {}

    it "requires a noun phrase", ->
      expect(@spy.mostRecentCall.args[1].noun).toBeTruthy()

    it "requires a verb phrase", ->
      expect(@spy.mostRecentCall.args[1].verb).toBeTruthy()

describe "MTNT.Collections.Entries", ->
  it "is a collection of entries", ->
    @entries = new MTNT.Collections.Entries
    expect(@entries.model).toEqual MTNT.Models.Entry
