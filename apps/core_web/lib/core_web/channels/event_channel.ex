defmodule CoreWeb.EventChannel do
  @moduledoc """
  Connect to events channel
  """

  use CoreWeb, :view

  require Logger
  use CoreWeb, :channel
  alias CoreWeb.Endpoint

  def join("events:all", _payload, socket) do
    {:ok, socket}
  end

  def broadcast_change(topic, event) do
    Endpoint.broadcast("events:all", topic, event)
    Logger.info fn ->
       "Broadcasting event to events:all"
    end
  end
end
