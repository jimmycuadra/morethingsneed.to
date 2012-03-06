class MTNT.Routers.App extends Backbone.Router
  routes:
    "": "main"

  main: ->
    @nav = $("#nav")
    @main = $("#main")

    navbar = new MTNT.Views.Navbar
    @nav.replaceWith(navbar.render().el)

    collection = new MTNT.Collections.Entries

    entries = new MTNT.Views.Entries(collection: collection)
    add_entry = new MTNT.Views.AddEntry(collection: collection)

    @main.html(add_entry.render().el)
    @main.append(entries.render().el)
