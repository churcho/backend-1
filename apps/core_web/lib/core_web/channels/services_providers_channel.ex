defmodule CoreWeb.ServicesProvidersChannel do
  @moduledoc """
  Connect to events channel
  """

  use CoreWeb, :view

  require Logger
  use CoreWeb, :channel
  alias CoreWeb.Endpoint

  def join("providers:all", _payload, socket) do
    {:ok, socket}
  end

  def broadcast_change(topic, event) do
    Endpoint.broadcast("providers:all", topic, event)
    Logger.info fn ->
       "Broadcasting event to providers:all"
    end
  end
end
