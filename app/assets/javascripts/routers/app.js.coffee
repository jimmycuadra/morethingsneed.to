class MTNT.Routers.App extends Backbone.Router
  routes:
    "": "main"

  main: ->
    @nav = $("#nav")
    @main = $("#main")

    navbar = new MTNT.Views.Navbar
    @nav.replaceWith(navbar.render().el)

    add_entry = new MTNT.Views.AddEntry
    @main.html(add_entry.render().el)

    collection = MTNT.app.entries = new MTNT.Collections.Entries
    entries = new MTNT.Views.Entries(collection: collection)
    @main.append(entries.render().el)
