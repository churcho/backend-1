defmodule CoreWeb.PlacesZonesChannel do
  @moduledoc """
  Connect to events channel
  """

  use CoreWeb, :view

  require Logger
  use CoreWeb, :channel
  alias CoreWeb.Endpoint

  def join("zones:all", _payload, socket) do
    {:ok, socket}
  end

  def broadcast_change(topic, event) do
    Endpoint.broadcast("zones:all", topic, event)
    Logger.info fn ->
       "Broadcasting event to zones:all"
    end
  end
end
