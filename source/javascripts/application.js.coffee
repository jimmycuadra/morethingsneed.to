#= require "vendor/amplify.store"
#= require "vendor/underscore"
#= require "vendor/backbone"
#= require "core"
#= require_tree "./models"
#= require_tree "./collections"
#= require_tree "./views"
#= require_tree "./routers"

mtnt.app = new mtnt.routers.ApplicationRouter
mtnt.app.loginView = new mtnt.views.LoginView
Backbone.history.start(pushState: true)
