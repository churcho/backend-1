defmodule CoreWeb.EntityMessageChannel do
  @moduledoc """
  Connect to events channel
  """


  require Logger

  use CoreWeb, :channel
  use CoreWeb, :view

  def join("entity_messages:" <> _entity_id, _payload, socket) do
    {:ok, socket}
  end

  def broadcast_change(message) do
    Logger.info(fn -> 'Message received: #{inspect message}' end)
    payload = %{
        "subject" => message.subject,
        "body" => message.payload["body"]
      }

    CoreWeb.Endpoint.broadcast("entity_messages:#{message.entity_id}", "change", payload)

    Logger.info fn ->
       "Broadcasting event to entity_messages:#{message.entity_id}"
    end
  end
end
