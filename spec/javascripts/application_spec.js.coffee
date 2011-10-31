EntriesView = MTNT.require "views/entries"

describe "MTNT", ->
  it "saves references to Extractor's methods", ->
    expect(MTNT.exports).toEqual Extractor.exports
    expect(MTNT.require).toEqual Extractor.require

  describe ".init", ->
    it "insantiates an entries view", ->
      MTNT.init()
      expect(MTNT.entries instanceof EntriesView).toBeTruthy()
