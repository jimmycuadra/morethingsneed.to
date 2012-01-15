#= require jquery.min
#= require application
#= require_self
#= require_tree ./

CustomMatchers =
  toBeAnInstanceOf: (expected) ->
    @actual instanceof expected

_.extend(jasmine.Matchers.prototype, CustomMatchers)
