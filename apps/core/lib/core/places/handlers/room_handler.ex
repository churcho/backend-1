defmodule Core.Places.RoomHandler do
  @moduledoc """
  Handle Events for persistence and execution
  """
  use GenServer
  alias CoreWeb.{
    EventChannel,
    PlacesRoomsChannel
  }


  def start_link do
    GenServer.start_link(
      __MODULE__,
      %{
        state: []
      },
      name: __MODULE__
    )
  end

  @doc """
  Initialize the Server
  """
  def init(state) do
    EventBus.subscribe({__MODULE__, [
      "places_room_created",
      "places_room_updated",
      "places_room_deleted",
      "places_room_event"
      ]})
    {:ok, state}
  end

  def process(event_shadow) do
    GenServer.cast(__MODULE__, event_shadow)
    :ok
  end

  def handle_cast({topic, id}, state) do
    event = Map.from_struct(EventBus.fetch_event({topic, id}))
    case topic do
      :places_room_created ->
        room_created(event)
      :places_room_updated ->
        room_updated(event)
      :places_room_deleted ->
        room_deleted(event)
      :places_room_event ->
        room_event(event)
      _ ->
        nil
    end
    # update the watcher!
    EventBus.mark_as_completed({__MODULE__, topic, id})
    {:noreply, state}
  end


  defp room_created(event) do
    IO.puts "ROOM_CREATED"
    PlacesRoomsChannel.broadcast_change("ROOM_CREATED", event.data)
  end

  defp room_updated(event) do
    IO.puts "ROOM_UPDATED"
    PlacesRoomsChannel.broadcast_change("ROOM_UPDATED", event.data)
  end

  defp room_deleted(event) do
    IO.puts "ROOM_DELETED"
    PlacesRoomsChannel.broadcast_change("ROOM_DELETED", event.data)
  end

  defp room_event(event) do
    IO.puts "ROOM_EVENT"
    EventChannel.broadcast_change("ROOM_EVENT", event.data)
  end
end
