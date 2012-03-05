class MTNT.Routers.App extends Backbone.Router
  routes:
    "": "main"

  main: ->
    navbar = new MTNT.Views.Navbar
    $("#main").html(navbar.render().el)
