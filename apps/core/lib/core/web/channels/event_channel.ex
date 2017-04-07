defmodule Core.Web.EventChannel do
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
          "logo" => Core.EventManager.logo_url(event),
          "icon" => Core.EventManager.icon_url(event)
        },
        "id" => event.id,
        "attributes" => %{
        "value" => event.value,
        "message" => event.message,
        "payload" => event.payload,
        "uuid" => event.uuid,
        "type" => event.type,
        "source" => event.source,
        "source_event" => event.source_event,
        "inserted_at" => event.inserted_at,
        "metadata" => event.metadata,
        "entity_id" => event.entity_id,
        "service_id" => event.service_id
      } 
    }

    Core.Web.Endpoint.broadcast("events:all", "change", payload)
  end
end
