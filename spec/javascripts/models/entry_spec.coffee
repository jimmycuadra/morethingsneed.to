describe "MTNT.Models.Entry", ->
  entry = null

  beforeEach ->
    entry = new MTNT.Models.Entry
    entry.collection = { url: "/entries" }

  it "requires a noun phrase", ->
    spy = jasmine.createSpy "error callback"
    entry.bind "error", spy
    entry.save {}
    expect(spy.mostRecentCall.args[1].noun).toEqual "noun phrase cannot be blank"
