defmodule CoreWeb.EntityMessageChannel do
  @moduledoc """
  Connect to events channel
  """

  use CoreWeb, :view

  require Logger
  use CoreWeb, :channel

  def join("entity_messages:" <> _entity_id, _payload, socket) do
    {:ok, socket}
  end

  def broadcast_change(message) do
    IO.inspect message
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
