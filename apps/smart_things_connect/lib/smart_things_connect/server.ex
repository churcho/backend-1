defmodule SmartThingsConnect.Server do
  @moduledoc """
  SmartThingsConnect Server
  """

  use GenServer

  @doc """
  Starts the server
  """
  def start_link do
    GenServer.start_link(__MODULE__, {})
  end

  def init(state) do
    SmartThingsConnect.register_provider()
    {:ok, state}
  end

  # Server Callbacks for Service Life Cycle

  @doc """
  Callback on install
  """
  def service_installed do
  end

  @doc """
  Callback on update
  """
  def service_updated do
    # Do something on update
  end

  @doc """
  Callback on service removal
  """
  def service_removed do
    # Do something on remove
  end
end
