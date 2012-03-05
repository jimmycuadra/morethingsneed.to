class MTNT.Routers.App extends Backbone.Router
  routes:
    "": "main"

  main: ->
    @main = $("#main")

    navbar = new MTNT.Views.Navbar
    @main.html(navbar.render().el)

    collection = MTNT.app.entries = new MTNT.Collections.Entries
    entries = new MTNT.Views.Entries(collection: collection)
    @main.append(entries.render().el)
