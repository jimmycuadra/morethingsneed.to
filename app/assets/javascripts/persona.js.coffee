class mtnt.Persona
  constructor: (currentUser) ->
    @currentUser = currentUser or null

  watch: ->
    navigator.id.watch
      loggedInUser: @currentUser
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
