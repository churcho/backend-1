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

  def broadcast_change(event) do
    Endpoint.broadcast("events:all", "change", event)
    Logger.info fn ->
       "Broadcasting event to events:all"
    end
  end
end
