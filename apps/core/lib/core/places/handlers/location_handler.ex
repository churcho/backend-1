defmodule Core.Places.LocationHandler do
  @moduledoc """
  Handle Events for persistence and execution
  """
  use GenServer
  alias CoreWeb.{
    EventChannel,
    PlacesLocationsChannel
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
      "places_location_created",
      "places_location_updated",
      "places_location_deleted",
      "places_location_event"
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
      :places_location_created ->
        location_created(event)
      :places_location_updated ->
        location_updated(event)
      :places_location_deleted ->
        location_deleted(event)
      :places_location_event ->
        location_event(event)
      _ ->
        nil
    end
    # update the watcher!
    EventBus.mark_as_completed({__MODULE__, topic, id})
    {:noreply, state}
  end


  defp location_created(event) do
    IO.puts "LOCATION_CREATED"
    job = %{
      name: String.to_atom("schedule_sunrise_for_#{event.data.id}"),
      cron_string: "*/1 * * * *",
      time_zone: event.data.timezone_id,
      command_string: 'Core.Places.update_sunrise_and_sunset("#{event.data.id}")'
    }
    Core.Scheduler.schedule(job)
    Core.Scheduler.create_or_update_job(job)
    PlacesLocationsChannel.broadcast_change("LOCATION_CREATED", event.data)
  end

  defp location_updated(event) do
    IO.puts "LOCATION_UPDATED"
    job = %{
      name: String.to_atom("schedule_sunrise_for_#{event.data.id}"),
      cron_string: "*/1 * * * *",
      time_zone: event.data.timezone_id,
      command_string: 'Core.Places.update_sunrise_and_sunset("#{event.data.id}")'
    }
    Core.Scheduler.delete_job(String.to_atom("schedule_sunrise_for_#{event.data.id}"))
    Core.Scheduler.schedule(job)
    Core.Scheduler.create_or_update_job(job)
    PlacesLocationsChannel.broadcast_change("LOCATION_UPDATED", event.data)
  end

  defp location_deleted(event) do
    IO.puts "LOCATION_DELETED"
    Core.Scheduler.delete_job(String.to_atom("schedule_sunrise_for_#{event.data.id}"))
    PlacesLocationsChannel.broadcast_change("LOCATION_DELETED", event.data)
  end

  defp location_event(event) do
    IO.puts "LOCATION_EVENT"
    EventChannel.broadcast_change("LOCATION_EVENT", event.data)
  end
end
