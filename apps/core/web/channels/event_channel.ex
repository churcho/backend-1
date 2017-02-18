defmodule Iotapi.EventChannel do
  @moduledoc """
  Connect to events channel
  """

  use Iotapi.Web, :channel

  def join("events:all", payload, socket) do
    {:ok, socket}
  end

  def broadcast_change(event) do
    payload = %{
      "message" => event.message,
      "payload" => event.payload,
      "entity" => event.entity,
      "type" => event.type,
      "source" => event.source
    }

    Iotapi.Endpoint.broadcast("events:all", "change", payload)
  end
end
