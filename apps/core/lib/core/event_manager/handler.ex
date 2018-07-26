defmodule Core.EventManager.Handler do
  @moduledoc """
  Handle Events for persistence and execution
  """
  use GenServer

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
    EventBus.subscribe({__MODULE__, [".*"]})
    {:ok, state}
  end

  def process({topic, id} = event_shadow) do
    GenServer.cast(__MODULE__, event_shadow)
    :ok
  end

  def handle_cast({topic, id}, state) do
    event = Map.from_struct(EventBus.fetch_event({topic, id}))
    # do sth with EventBus.Model.Event
    Core.EventManager.create_event(event)
    # update the watcher!
    EventBus.mark_as_completed({__MODULE__, topic, id})
    {:noreply, state}
  end
end
