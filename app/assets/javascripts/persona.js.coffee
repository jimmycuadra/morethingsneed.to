class mtnt.Persona
  constructor: (loggedInUser) ->
    @loggedInUser = loggedInUser or null

  watch: ->
    navigator.id.watch
      loggedInUser: @loggedInUser
      onlogin: @login
      onlogout: ->

  login: (assertion) ->
    $.ajax
      type: "POST"
      url: "/sessions",
      data: { assertion: assertion }
      dataType: "text"
      success: mtnt.reload
      failure: (xhr, status, err) ->
        console.log(xhr, status, err)
