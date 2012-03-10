class MTNT.Routers.App extends Backbone.Router
  routes:
    "": "main"

  main: ->
    ## Collections

    @collection = new MTNT.Collections.Entries

    ## DOM elements
    $body = $("body")
    $main = $("#main")

    ## Remove loading state
    $("#no-js").remove()

    ## Views

    # Navigation
    navbar = new MTNT.Views.Navbar
    $body.prepend(navbar.render().el)

    # Add entry form
    add_entry = new MTNT.Views.AddEntry(collection: @collection)
    $main.append(add_entry.render().el)

    # Flash messages
    @flash = new MTNT.Views.FlashMessages
    $main.append(@flash.el)

    # Entries
    entries = new MTNT.Views.Entries(collection: @collection)
    $main.append(entries.render().el)
