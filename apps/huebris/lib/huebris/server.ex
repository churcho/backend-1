defmodule Huebris.Server do
  @moduledoc """
  Server Module
  """
  require Logger
  use GenServer
  alias Core.ServiceManager

  @doc """
  Starts the server
  """
  def start_link() do
  	 GenServer.start_link(__MODULE__, %{services: %{}, bridges: %{}, entities: %{}}, name: __MODULE__)
  end

  @doc """
  Ininitalze the server.
  We will init the scheduler service and return the state.
  """
  def init(state) do
    #Register the provider
  	Huebris.register_provider
    Huebris.Server.build_state
    Huebris.Scheduler.start_link
    #Return state
    {:ok, state}
  end

  #Server Callbacks for Service Life Cycle

  @doc """
  Callback on install
  """
  def service_installed() do
    # Do something on install
    build_state()
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
  def fetch_services() do
    GenServer.call(__MODULE__, :fetch_services)
  end

  @doc """
  Loads authorized bridges into state
  """
  def load_bridges(loaded_bridges) do
    GenServer.cast(__MODULE__, {:load_bridges, loaded_bridges})
  end

  @doc """
  Fetches the bridge from state
  """
  def fetch_bridges() do
    GenServer.call(__MODULE__, :fetch_bridges)
  end

  @doc """
  Clear the state
  """
  def clear_state() do
    Huebris.Server.load_services(%{})
    Huebris.Server.load_bridges(%{})
  end

  @doc """
  Build a state object by iterating through the available Huebris services that
  have been authorzied.
  """
  def build_state() do
      services = find_enabled_services()
      if services do
        for service <- services do
          target =
          service
          |> Core.Repo.preload(:entities)

          load_target =
          target.name
          |> String.downcase
          |> String.replace(" ", "_")
          |> String.to_atom

          new_service_map = %{load_target => target}
          Huebris.Server.load_services(new_service_map)
        end
      end
  end

  @doc """
  Retreieve a list of enabled services from Core/Data
  """
  def find_enabled_services() do
  	providers = ServiceManager.get_provider_by_lorp_name("Huebris")
  	providers.services
  end

  @doc """
  Create a new bridge object
  """
  def build_bridge(service) do
    service.host
    |> Huebris.Client.connect(service.api_key)
    |> Huebris.Client.getlights
  end

  @doc """
  Function that takes two entities and compares the states.
  """
  def state_check(entity_a, entity_b) do
    if entity_a == entity_b do
      true
    else
      false
    end
  end

  @doc """
  Poll function
  """
  def poll() do
    services = Huebris.Server.fetch_services
    for {_key, value} <- services do
       if value != %{} do
         new_bridge = build_bridge(value)
         current_bridge = Huebris.Server.fetch_bridges
         if current_bridge != new_bridge do
           Huebris.Poller.poll(current_bridge, new_bridge)
         end
       end
    end

  end

  #handle calls/casts

  def handle_call(:fetch_services, _from, state) do
    {:reply, state.services, state}
  end

  def handle_call(:fetch_bridges, _from, state) do
    {:reply, state.bridges, state}
  end

  def handle_cast({:load_services, loaded_services}, state) do
    service_target = Map.merge(state.services, loaded_services)
    {:noreply, %{state | services: service_target}}
  end

  def handle_cast({:load_bridges, loaded_bridges}, state) do
    {:noreply, %{state | bridges: loaded_bridges}}
  end
end
