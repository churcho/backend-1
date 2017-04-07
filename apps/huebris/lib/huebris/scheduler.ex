defmodule Huebris.Scheduler do
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
   	Huebris.Server.poll()
    #Reschedule once more
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
  	#We will poll the hue bridge every 200 ms
    Process.send_after(self(), :work, 1000)
  end
end