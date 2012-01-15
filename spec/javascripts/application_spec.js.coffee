describe "MTNT", ->
  describe ".init", ->
    it "insantiates an entries view", ->
      MTNT.init()
      expect(MTNT.entries).toBeAnInstanceOf(MTNT.EntriesView)
