defmodule Core.EventChannel do
  @moduledoc """
  Connect to events channel
  """

  use Core.Web, :channel

  def join("events:all", payload, socket) do
    {:ok, socket}
  end

  def broadcast_change(event) do
    payload = %{ 
        "links" => %{
          "self" =>  "/api/v1/events/#{event.id}",
          "logo" => Core.Event.logo_url(event),
          "icon" => Core.Event.icon_url(event)
        },
        "attributes" => %{
          "value" => event.value,
          "message" => event.message,
          "payload" => event.payload,
          "entity" => event.entity,
          "type" => event.type,
          "source" => event.source,
          "inserted_at" => event.inserted_at
      } 
    }

    Core.Endpoint.broadcast("events:all", "change", payload)
  end
end
