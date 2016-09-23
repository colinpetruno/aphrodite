App.stylesheet = App.cable.subscriptions.create {
  channel: "StylesheetChannel",
  stylesheet_id: $("#edit-stylesheet").data("stylesheet-id")
},
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    document.getElementById('preview-iframe').contentWindow.location.reload()
    $("#iframe-spinner").addClass("hidden-xs-up")
    $("#preview-iframe").show()
    # Called when there's incoming data on the websocket for this channel

  update: ->
    @perform 'update'
