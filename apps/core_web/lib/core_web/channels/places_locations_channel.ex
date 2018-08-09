defmodule CoreWeb.PlacesLocationsChannel do
  @moduledoc """
  Connect to events channel
  """

  use CoreWeb, :view

  require Logger
  use CoreWeb, :channel
  alias CoreWeb.Endpoint

  def join("locations:all", _payload, socket) do
    {:ok, socket}
  end

  def broadcast_change(topic, event) do
    Endpoint.broadcast("locations:all", topic, event)
    Logger.info fn ->
       "Broadcasting event to locations:all"
    end
  end
end
