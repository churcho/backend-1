defmodule Huebris.Server do
	use GenServer
	alias Core.ServiceManager
	alias Core.ServiceManager.Service
	
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
		IO.puts "No stations. We need to put some in an agent"
	  	services = find_enabled_services
	  	if services != nil do
	    	for service <- services do 
	    		if service.authorized do
		    		bridge = Huebris.connect(service.host, service.api_key)
					|> Huebris.getlights

					Agent.update(HueMemState, &(&1=service))
		    		Agent.update(HueBridges, &(&1=bridge))
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

	def poll() do
		

		if Agent.get(HueMemState, &(&1)) == %{} do
		  	Huebris.Server.build_state
		else
			service = Agent.get(HueMemState, &(&1))

			bridge = Huebris.connect(service.host, service.api_key)
			|> Huebris.getlights

	 	  	if Agent.get(HueBridges, &(&1)) != bridge do
	 	  	  Agent.update(HueBridges, &(&1=bridge))
			  Huebris.Poller.poll(service)
			end
		end
	end
end