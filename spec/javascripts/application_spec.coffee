describe "MTNT", ->
  it "exists", ->
    expect(typeof window.MTNT).toEqual("object")

  describe ".init", ->
    it "insantiates an entry collection", ->
      MTNT.init()
      expect(MTNT.Instances.entries instanceof MTNT.Collections.Entries).toBeTruthy()
