describe "MTNT.Views.Entry", ->
  beforeEach ->
    @entry = new MTNT.Views.Entry(new MTNT.Models.Entry)

  describe "#initialize", ->
    it "initializes a model with the supplied data", ->
      expect(@entry.model instanceof MTNT.Models.Entry).toBeTruthy()
