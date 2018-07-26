defmodule Darko.Server do
  @moduledoc """
  DarkSky Weather Server.
  """
  require Logger
  use GenServer
  alias Core.{Services, Places}
  alias Darko.{Server, Scheduler, Poller}

  @doc """
    Starts the server
  """
  def start_link do
    GenServer.start_link(
      __MODULE__,
      %{
        service: %{},
        locations: %{}
      },
      name: __MODULE__
    )
  end

  @doc """
  Initialize the Server
  """
  def init(state) do
    Darko.register_provider()
    Server.build_state()
    Scheduler.start_link()
    {:ok, state}
  end

  # Server Callbacks for Service Life Cycle

  @doc """
  Callback on install
  """
  def service_installed do
    # Do something on install
    build_state()
  end

  @doc """
  Callback on update
  """
  def service_updated do
    # Do something on update
    build_state()
  end

  @doc """
  Callback on service removal
  """
  def service_removed do
    # Do something on remove
    clear_state()
  end

  @doc """
  Loads authorized serivces into state
  """
  def load_service(loaded_service) do
    GenServer.cast(__MODULE__, {:load_service, loaded_service})
  end

  @doc """
  Fetches the services from state
  """
  def fetch_service do
    GenServer.call(__MODULE__, :fetch_service)
  end

  @doc """
  Loads authorized stations into state
  """
  def load_locations(loaded_locations) do
    GenServer.cast(__MODULE__, {:load_locations, loaded_locations})
  end

  @doc """
  Fetches the station from state
  """
  def fetch_locations do
    GenServer.call(__MODULE__, :fetch_locations)
  end

  @doc """
  Build the state
  """
  def build_state do
    service = find_enabled_service()
    if service do
        Server.load_service(service)
        Server.load_locations(Places.list_locations)
    end
  end

  def clear_state do
    Server.load_service(%{})
    Server.load_locations(%{})
  end

  def find_enabled_service do
    provider =
    Services.provider_by_service_name("Darko")
    List.first(provider.connections)
  end

  def poll do
    locations = Server.fetch_locations()
    service = Server.fetch_service()
    for location <- locations do
      Poller.poll(service, location)
    end
  end

  # GenServer Implementation
  # handle calls/casts
  def handle_call(:stop, _from, status) do
    {:stop, :normal, status}
  end

  def handle_call(:fetch_service, _from, state) do
    {:reply, state.service, state}
  end

  def handle_call(:fetch_locations, _from, state) do
    {:reply, state.locations, state}
  end

  def handle_cast({:load_service, loaded_service}, state) do
    service_target = Map.merge(state.service, loaded_service)
    {:noreply, %{state | service: service_target}}
  end

  def handle_cast({:load_locations, loaded_locations}, state) do
    {:noreply, %{state | locations: loaded_locations}}
  end
end
