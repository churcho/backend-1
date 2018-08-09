defmodule Core.Places.ZoneHandler do
  @moduledoc """
  Handle Events for persistence and execution
  """
  use GenServer
  alias CoreWeb.{
    EventChannel,
    PlacesZonesChannel
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
      "places_zone_created",
      "places_zone_updated",
      "places_zone_deleted",
      "places_zone_event"
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
      :places_zone_created ->
        zone_created(event)
      :places_zone_updated ->
        zone_updated(event)
      :places_zone_deleted ->
        zone_deleted(event)
      :places_zone_event ->
        zone_event(event)
      _ ->
        nil
    end
    # update the watcher!
    EventBus.mark_as_completed({__MODULE__, topic, id})
    {:noreply, state}
  end


  defp zone_created(event) do
    IO.puts "ZONE_CREATED"
    PlacesZonesChannel.broadcast_change("ZONE_CREATED", event.data)
  end

  defp zone_updated(event) do
    IO.puts "ZONE_UPDATED"
    PlacesZonesChannel.broadcast_change("ZONE_UPDATED", event.data)
  end

  defp zone_deleted(event) do
    IO.puts "ZONE_DELETED"
    PlacesZonesChannel.broadcast_change("ZONE_DELETED", event.data)
  end

  defp zone_event(event) do
    IO.puts "ZONE_EVENT"
    EventChannel.broadcast_change("ZONE_EVENT", event.data)
  end
end
