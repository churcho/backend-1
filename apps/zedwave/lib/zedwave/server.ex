defmodule Zedwave.Server do
  @moduledoc """
  The server module handles all IO for your app. Given that it is based on
  GenServer, it follows the same conventions.
  """
  require Logger
  use GenServer
  #alias Core.ServiceManager

  # alias any commonly used items here #

  @doc """
  We will use start_link to init the server.

  __MODULE__ is a reference to the current Module. In our case,
  Zedwave.Server

  %{} is the intial state we are passing the server.

  We are then assigning the server the same name as the current module.
  """
  def start_link() do
      GenServer.start(__MODULE__, %{}, name: __MODULE__)
  end


  @doc """
  The init function will be called once the server has been started.
  Common actions in the init function are registering a provider(App) with
  the core service manager and kicking off any processes that you want.
  """
  def init(state) do
    # Call the register_provider function.
    Zedwave.register_provider
    #Return state
    {:ok, state}
  end


  # Below are the required functions that you need to support.

  @doc """
  service_installed will be called every time your service is installed.
  """
  def service_installed() do
    # Do something here when the service is installed
  end

  @doc """
  service updated will be called every time your service is updated.
  """
  def service_updated() do
    # do something here when the service is updated
  end

  @doc """
  service_removed will be called when someone removes the service.
  """
  def service_removed() do
    # do something here when the service is removed
  end

  @doc """
  Polling:
  """
  def poll() do
      # if your app supports polling, handle that here.
  end


  # handle all of your calls/casts here #



end
