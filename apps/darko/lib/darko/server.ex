defmodule Darko.Server do
  @moduledoc """
  DarkSky Weather Server.
  """
  require Logger
  use GenServer
  alias Core.{ProviderManager, Repo}
  alias Darko.{Server, Scheduler, Poller}

  @doc """
    Starts the server
  """
  def start_link do
    GenServer.start_link(
      __MODULE__,
      %{
        services: %{},
        stations: %{}
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
  def load_services(loaded_services) do
    GenServer.cast(__MODULE__, {:load_services, loaded_services})
  end

  @doc """
  Fetches the services from state
  """
  def fetch_services do
    GenServer.call(__MODULE__, :fetch_services)
  end

  @doc """
  Loads authorized stations into state
  """
  def load_stations(loaded_stations) do
    GenServer.cast(__MODULE__, {:load_stations, loaded_stations})
  end

  @doc """
  Fetches the station from state
  """
  def fetch_stations do
    GenServer.call(__MODULE__, :fetch_stations)
  end

  @doc """
  Build the state
  """
  def build_state do
    services = find_enabled_services()

    if services do
      for service <- services do
        target =
          service
          |> Repo.preload(:entities)

        load_target =
          target.name
          |> String.downcase()
          |> String.to_atom()

        new_service_map = %{load_target => target}

        Server.load_services(new_service_map)
        Server.load_stations(target.entities)
      end
    end
  end

  def clear_state do
    Server.load_services(%{})
    Server.load_stations(%{})
  end

  def find_enabled_services do
    providers = ProviderManager.get_provider_by_lorp_name("Darko")
    providers.services
  end

  def poll do
    stations = Server.fetch_stations()

    for entity <- stations do
      Poller.poll(entity)
    end
  end

  # GenServer Implementation
  # handle calls/casts
  def handle_call(:stop, _from, status) do
    {:stop, :normal, status}
  end

  def handle_call(:fetch_services, _from, state) do
    {:reply, state.services, state}
  end

  def handle_call(:fetch_stations, _from, state) do
    {:reply, state.stations, state}
  end

  def handle_cast({:load_services, loaded_services}, state) do
    service_target = Map.merge(state.services, loaded_services)
    {:noreply, %{state | services: service_target}}
  end

  def handle_cast({:load_stations, loaded_stations}, state) do
    {:noreply, %{state | stations: loaded_stations}}
  end
end
