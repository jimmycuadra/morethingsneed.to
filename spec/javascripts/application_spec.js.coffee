EntriesView = MTNT.require "views/entries"

describe "MTNT", ->
  it "saves references to Extractor's methods", ->
    expect(MTNT.exports).toBe Extractor.exports
    expect(MTNT.require).toBe Extractor.require

  describe ".init", ->
    it "insantiates an entries view", ->
      MTNT.init()
      expect(MTNT.entries).toBeAnInstanceOf EntriesView
