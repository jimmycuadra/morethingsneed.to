describe "MTNT.Views.Entry", ->
  beforeEach ->
    @entry = new MTNT.Views.Entry(model: new MTNT.Models.Entry)

  describe "#initialize", ->
    it "initializes a model with the supplied data", ->
      expect(@entry.model instanceof MTNT.Models.Entry).toBeTruthy()

  describe "#render", ->
    it "renders the template to @el", ->
      @entry.model.set(noun: "tests", needs: false, verb: "be run")
      @entry.render()
      expect(@entry.el.innerHTML).toEqual "More tests need to be run."
