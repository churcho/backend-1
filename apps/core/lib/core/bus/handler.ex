defmodule Core.Bus.Handler do
  @moduledoc """
  Handle Events for persistence and execution
  """
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc """
  Initialize the Server
  """
  def init(_opts) do
    :ok = EventBus.subscribe({__MODULE__, [".*"]})
    {:ok, []}
  end

  def process(event_shadow) do
    GenServer.cast(__MODULE__, event_shadow)
    :ok
  end

  def handle_cast(event_shadow, state) do
    IO.puts "creating event"
    event = Map.from_struct(EventBus.fetch_event(event_shadow))
    Core.Bus.create_event(event)

    # update the watcher!
    EventBus.mark_as_completed({__MODULE__, event_shadow})

    {:noreply, state}
  end
end
