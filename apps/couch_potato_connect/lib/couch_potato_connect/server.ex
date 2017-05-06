defmodule CouchPotatoConnect.Server do
  @moduledoc """
  CouchPotato Server
  """
  require Logger
  use GenServer
  #alias Core.ServiceManager

  @doc """
  Starts the server
  """
  def start_link() do
  	 GenServer.start_link(__MODULE__, {})
  end

  @doc """
  init takes state and runs any valid commands
  """
  def init(state) do
  	CouchPotatoConnect.register_provider
  	{:ok, state}
  end

  #Server Callbacks for Service Life Cycle

  @doc """
  Callback on install
  """
  def service_installed() do
    # Do something on install
  end

  @doc """
  Callback on update
  """
  def service_updated() do
    # Do something on update
  end

  @doc """
  Callback on service removal
  """
  def service_removed() do
    # Do something on remove
  end
end
