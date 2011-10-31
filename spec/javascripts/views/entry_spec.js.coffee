EntryView = Extractor.require "views/entry"
Entry = Extractor.require "models/entry"

describe "EntryView", ->
  beforeEach ->
    @entry = new EntryView(model: new Entry)

  describe "#initialize", ->
    it "initializes a model with the supplied data", ->
      expect(@entry.model instanceof Entry).toBeTruthy()

  describe "#render", ->
    it "renders the template to @el", ->
      @entry.model.set(noun: "tests", needs: false, verb: "be run")
      @entry.render()
      expect(@entry.el.innerHTML).toEqual "More tests need to be run."
