describe "Entries", ->
  it "is a collection of entries", ->
    @entries = new MTNT.Entries
    expect(@entries.model).toBe(MTNT.Entry)
