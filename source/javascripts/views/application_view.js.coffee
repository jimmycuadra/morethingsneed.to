class mtnt.views.ApplicationView extends Backbone.View
  el: "body"

  events:
    "click .nav-entries": "navigateEntries"
    "click .nav-users": "navigateUsers"
    "click .nav-settings": "navigateSettings"

  initialize: ->
    @nav = $(".nav li")
    @loginView = new mtnt.views.LoginView
    @loginView.render()

  refreshNavbar: (activeTab) ->
    @nav.removeClass("active")
    @nav.filter(".tab-#{activeTab}").addClass("active") if activeTab

  navigateEntries: (event) ->
    event.preventDefault()
    mtnt.app.router.navigate("", trigger: true)

  navigateUsers: (event) ->
    event.preventDefault()
    mtnt.app.router.navigate("users", trigger: true)

  navigateSettings: (event) ->
    event.preventDefault()
    mtnt.app.router.navigate("settings", trigger: true)
