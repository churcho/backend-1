defmodule CoreWeb.PlacesRoomsChannel do
  @moduledoc """
  Connect to events channel
  """

  use CoreWeb, :view

  require Logger
  use CoreWeb, :channel
  alias CoreWeb.Endpoint

  def join("rooms:all", _payload, socket) do
    {:ok, socket}
  end

  def broadcast_change(topic, event) do
    Endpoint.broadcast("rooms:all", topic, event)
    Logger.info fn ->
       "Broadcasting event to rooms:all"
    end
  end
end
