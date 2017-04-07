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
    GenServer.start_link(__MODULE__, {})
  end



  def handle_call(:stop, _from, status) do
    {:stop, :normal, status}
  end

  def init(state) do
  	Agent.start_link(fn -> %{} end, name: DarkoMemState)
  	Agent.start_link(fn -> %{} end, name: DarkoStations)
    
    IO.puts "Registering Dark Sky Connect...."
    Darko.register_provider
    Darko.Server.build_state
    Darko.Scheduler.start_link
  	{:ok, state}
  end

  def build_state() do 
    IO.puts "No stations. We need to put some in an agent"
      service = find_enabled_service
      Agent.update(DarkoStations, &(&1=service))

      if Agent.get(DarkoStations, &(&1)) != nil do
        Darko.Importer.import(Agent.get(DarkoStations, &(&1)))
      end
  end

  def find_enabled_service() do
    ServiceManager.get_service_by_name("Darko")
  end

  def poll() do
    if Agent.get(DarkoStations, &(&1)) == %{} do
      Darko.Server.build_state
    else
    service = Agent.get(DarkoStations, &(&1))
      for entity <- service.entities do
        Darko.Poller.poll(entity)
      end
    end
  end

  @base_url "https://api.darksky.net/forecast"

   

   def forecast(lat, lng, token, params \\ defaults) do
     read("#{token}/#{lat},#{lng}", params)
   end

   def time_machine(lat, lng, time, token, params \\ defaults) do
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
    |> Darko.Server.get(request_headers)
    |> Parser.parse
  end

  def process_params(nil) do
    defaults
  end

  def process_params(params) do
    defaults
    |> Map.merge(params)
    |> Map.delete(:__struct__)
  end
end