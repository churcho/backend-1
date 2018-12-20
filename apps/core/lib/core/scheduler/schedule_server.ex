defmodule Core.Scheduler.Server do
  @moduledoc """
  Scheduler Server to start schedules on restart
  """
  use GenServer
  alias Core.Scheduler

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc """
  Initialize the Server
  """
  def init(_opts) do
    jobs = Scheduler.list_created_jobs()

    IO.inspect jobs
    :ok = IO.puts "Scheduler Started!"
    {:ok, []}
  end
end
