EntriesView = Extractor.require "views/entries"
Entries = Extractor.require "collections/entries"
Entry = Extractor.require "models/entry"

describe "EntriesView", ->
  beforeEach ->
    @entries = new EntriesView

  describe "#initialize", ->
    it "instantiates an entry collection", ->
      expect(@entries.collection instanceof Entries).toBeTruthy()

  describe "#addOne", ->
    it "appends the entry view to the entries view", ->
      @entries.el = $("<section/>")
      model = new Entry(noun: "tests", needs: false, verb: "be run")
      @entries.addOne model
      expect(@entries.el.html()).toMatch /More tests need to be run./

  describe "#addAll", ->
    it "calls #addOne for each model in the collection", ->
      spyOn @entries, "addOne"
      @entries.collection.reset [new Backbone.Model, new Backbone.Model, new Backbone.Model]
      expect(@entries.addOne.callCount).toEqual 3
