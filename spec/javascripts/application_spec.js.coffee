describe "MTNT", ->
  it "exists", ->
    expect(typeof window.MTNT).toEqual("object")

  describe ".init", ->
    it "insantiates an entries view", ->
      MTNT.init()
      expect(MTNT.Instances.entries instanceof MTNT.Views.Entries).toBeTruthy()
