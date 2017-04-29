defmodule Darko.Server do
  @moduledoc """
  DarkSky Weather Server.
  """
  import Darko.Utils
  use GenServer

  alias Core.ServiceManager
  use HTTPoison.Base
  alias Darko.Parser



  @doc """
    Starts the server
  """
  def start_link() do
     GenServer.start_link(__MODULE__, %{services: %{}, stations: %{}}, name: __MODULE__)
  end

  @doc """
  Initialize the Server
  """
  def init(state) do
    IO.puts "Registering Dark Sky Connect...."
    Darko.register_provider
    Darko.Server.build_state()
    Darko.Scheduler.start_link
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
    build_state()
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
  Loads authorized stations into state
  """
  def load_stations(loaded_stations) do
    GenServer.cast(__MODULE__, {:load_stations, loaded_stations})
  end

  @doc """
  Fetches the station from state
  """
  def fetch_stations() do
    GenServer.call(__MODULE__, :fetch_stations)
  end



  @doc """
  Build the state
  """
  def build_state() do

    IO.puts "No stations. We need to put some in an agent"
      services = find_enabled_services()
      if services do
        for service <- services do
          target =
          service
          |> Core.Repo.preload(:entities)

          load_target =
          target.name
          |> String.downcase
          |> String.to_atom

          new_service_map = %{load_target => target}

          Darko.Server.load_services(new_service_map)
          Darko.Server.load_stations(target.entities)

        end
      end
  end

  def clear_state() do
    Darko.Server.load_services(%{})
    Darko.Server.load_stations(%{})
  end

  def find_enabled_services() do
    providers = ServiceManager.get_provider_by_lorp_name("Darko")
  	providers.services
  end

  def poll() do

    stations = Darko.Server.fetch_stations()

    for entity <- stations do
      IO.puts "polling.........."
      Darko.Poller.poll(entity)
    end
  end

  @base_url "https://api.darksky.net/forecast"



   def forecast(lat, lng, token, params \\ defaults()) do
     read("#{token}/#{lat},#{lng}", params)
   end

   def time_machine(lat, lng, time, token, params \\ defaults()) do
     read("#{token}/#{lat},#{lng},#{time}", params)
   end

   def build_url(path_arg, query_params) do
    query_params = query_params
      |> process_params
    "#{@base_url}/#{path_arg}?#{URI.encode_query(query_params)}"
   end

   def read(path_arg, query_params \\ %{}) do
    path_arg
    |> build_url(query_params)
    |> Darko.Server.get(request_headers())
    |> Parser.parse
  end

  def process_params(nil) do
    defaults()
  end

  def process_params(params) do
    defaults()
    |> Map.merge(params)
    |> Map.delete(:__struct__)
  end


  #GenServer Implementation
  #handle calls/casts
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
