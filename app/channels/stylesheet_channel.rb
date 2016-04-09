# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class StylesheetChannel < ApplicationCable::Channel
  def subscribed
    stream_from "stylesheet"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def update
    ActionCable.server.broadcast "stylesheet", message: "hello"
  end
end
