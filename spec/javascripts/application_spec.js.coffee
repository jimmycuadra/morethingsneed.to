EntriesView = Extractor.require "EntriesView"

describe "MTNT", ->
  it "exists", ->
    expect(typeof window.MTNT).toEqual("object")

  describe ".init", ->
    it "insantiates an entries view", ->
      MTNT.init()
      expect(MTNT.entries instanceof EntriesView).toBeTruthy()
