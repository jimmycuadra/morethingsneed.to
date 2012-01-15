describe "EntryView", ->
  beforeEach ->
    @entry = new MTNT.EntryView(model: new MTNT.Entry)

  describe "#initialize", ->
    it "initializes a model with the supplied data", ->
      expect(@entry.model).toBeAnInstanceOf(MTNT.Entry)

  describe "#render", ->
    it "renders the template to @el", ->
      spyOn(@entry, "template").andReturn("Rendered!")
      @entry.render()
      expect(@entry.el.innerHTML).toMatch(/Rendered!/)
