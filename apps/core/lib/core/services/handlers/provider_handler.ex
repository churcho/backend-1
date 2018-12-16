defmodule Core.Services.ProviderHandler do
  @moduledoc """
  Handle Events for persistence and execution
  """
  use GenServer
  alias CoreWeb.{
    EventChannel,
    ServicesProvidersChannel
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
      "services_provider_created",
      "services_provider_updated",
      "services_provider_deleted",
      "services_provider_event"
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
      :services_provider_created ->
        provider_created(event)
      :services_provider_updated ->
        provider_updated(event)
      :services_provider_deleted ->
        provider_deleted(event)
      :services_provider_event ->
        provider_event(event)
      _ ->
        nil
    end
    # update the watcher!
    EventBus.mark_as_completed({__MODULE__, topic, id})
    {:noreply, state}
  end


  defp provider_created(event) do
    IO.puts "PROVIDER_CREATED"
    ServicesProvidersChannel.broadcast_change("PROVIDER_CREATED", event.data)
  end

  defp provider_updated(event) do
    IO.puts "PROVIDER_UPDATED"
    ServicesProvidersChannel.broadcast_change("PROVIDER_UPDATED", event.data)
  end

  defp provider_deleted(event) do
    IO.puts "PROVIDER_DELETED"
    ServicesProvidersChannel.broadcast_change("RPROVIDER_DELETED", event.data)
  end

  defp provider_event(event) do
    IO.puts "PROVIDER_EVENT"
    EventChannel.broadcast_change("PROVIDER_EVENT", event.data)
  end
end
