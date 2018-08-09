defmodule Core.Bus.MiddleWare do
  @moduledoc """
  EventBus MiddleWare
  """

  alias EventBus.Model.Event

  def create(event) do
    %Event{
      id: UUID.uuid4(),
      transaction_id: UUID.uuid4(),
      topic: event.topic,
      data: parse_data(event.data),
      initialized_at:  DateTime.utc_now |> DateTime.to_unix,
      occurred_at:  0,
      ttl: 30_000,
      source: event.source
    }
  end

  def send(event) do
    EventBus.notify(event)
  end

  defp parse_data(data) do
    Map.from_struct(data)
    |> Map.delete(:__meta__)
    |> Map.delete(:__struct__)
  end
end
