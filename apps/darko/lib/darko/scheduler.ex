defmodule Darko.Scheduler do
  @moduledoc """
  Scheduler
  """
  use GenServer
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    # Schedule work to be performed at some point
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
   	Darko.Server.poll()
    #Reschedule once more
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
  	#We will poll the Dark Sky API every 3 minutes
    Process.send_after(self(), :work, 180_000)
  end
end
