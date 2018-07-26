defmodule Core.EventManager.EventBus do
  @moduledoc """
  EventBus MiddleWare
  """

  alias EventBus.Model.Event

  def create(event) do
    %Event{
      id: UUID.uuid4(),
      transaction_id: UUID.uuid4(),
      topic: event.topic,
      data: event.data,
      initialized_at:  DateTime.utc_now |> DateTime.to_unix,
      source: event.source
    }
  end
end
