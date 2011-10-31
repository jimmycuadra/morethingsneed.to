EntryView = Extractor.require "views/entry"
Entry = Extractor.require "models/entry"

describe "EntryView", ->
  beforeEach ->
    @entry = new EntryView(model: new Entry)

  describe "#initialize", ->
    it "initializes a model with the supplied data", ->
      expect(@entry.model).toBeAnInstanceOf Entry

  describe "#render", ->
    it "renders the template to @el", ->
      spyOn(@entry, "template").andReturn "Rendered!"
      @entry.render()
      expect(@entry.el.innerHTML).toMatch /Rendered!/
