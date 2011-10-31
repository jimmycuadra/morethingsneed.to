Entry = Extractor.require "models/entry"
Entries = Extractor.require "collections/entries"

describe "Entry", ->
  it "has a default 'needs' attribute", ->
    @entry = new Entry
    expect(@entry.get "needs").toBe false

  describe "required attributes", ->
    beforeEach ->
      @entry = new Entry
      @entry.collection = { url: "/entries" }
      @spy = jasmine.createSpy "error callback"
      @entry.bind "error", @spy
      @entry.save {}

    it "requires a noun phrase", ->
      expect(@spy.mostRecentCall.args[1].noun).toBeTruthy()

    it "requires a verb phrase", ->
      expect(@spy.mostRecentCall.args[1].verb).toBeTruthy()

describe "Entries", ->
  it "is a collection of entries", ->
    @entries = new Entries
    expect(@entries.model).toBe Entry
