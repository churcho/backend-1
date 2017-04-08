defmodule Huebris.Server do
  @moduledoc """
  Server Module
  """
  use GenServer
  alias Core.ServiceManager

  @doc """
  Starts the server
  """
  def start_link() do
  	 GenServer.start_link(__MODULE__, {})
  end


  def init(state) do

  	IO.puts "Registering Huebris...."
  	Huebris.register_provider
  	Agent.start_link(fn -> %{} end, name: HueMemState)
    	Agent.start_link(fn -> %{} end, name: HueBridges)
    	Huebris.Scheduler.start_link
  	{:ok, state}
  end


  def build_state() do
  	services = find_enabled_services()
  	if services != nil do
    	for service <- services do
    		if service.authorized do
  	    	bridge =
          service.host
          |> Huebris.connect(service.api_key)
          |> Huebris.getlights

  				Agent.update(HueMemState, &(&1 = service))
  	    	Agent.update(HueBridges, &(&1 = bridge))
      	end
      end
     else
  	     IO.puts "Stopping here. No enabled Services"
  	end
  end

  def find_enabled_services() do
  	providers = ServiceManager.get_provider_by_lorp_name("Huebris")
  	providers.services
  end

  def build_bridge(service) do
    service.host
    |> Huebris.connect(service.api_key)
    |> Huebris.getlights
  end

  def state_check(entity_a, entity_b) do
    if entity_a == entity_b do
      true
    else
      false
    end
  end

  def poll() do
  	if Agent.get(HueMemState, &(&1)) == %{} do
  	  	Huebris.Server.build_state

  	else
  		service = Agent.get(HueMemState, &(&1))
  		new_bridge = build_bridge(service)
      current_bridge = Agent.get(HueBridges, &(&1))

   	  if current_bridge != new_bridge do
  		  Huebris.Poller.poll(current_bridge, new_bridge)
  		end

  	end
  end
end
