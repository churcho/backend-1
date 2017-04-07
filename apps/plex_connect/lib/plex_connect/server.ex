defmodule PlexConnect.Server do
	use GenServer
	 @doc """
	Starts the server
	"""
	def start_link() do
		 GenServer.start_link(__MODULE__, {})
	end


	def init(state) do
		
		IO.puts "Registering Sabnzbd...."
		PlexConnect.register_provider
		{:ok, state}
	end
end