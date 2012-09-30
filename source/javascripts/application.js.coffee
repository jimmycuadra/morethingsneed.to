#= require "vendor/amplify.store"
#= require "vendor/underscore"
#= require "vendor/backbone"
#= require "hamlcoffee"
#= require "core"
#= require_tree "./models"
#= require_tree "./collections"
#= require_tree "./templates"
#= require_tree "./views"
#= require_tree "./routers"

mtnt.app.session = new mtnt.models.Session
mtnt.app.router = new mtnt.routers.ApplicationRouter
Backbone.history.start(pushState: true)
