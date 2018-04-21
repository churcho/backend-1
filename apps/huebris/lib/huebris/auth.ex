defmodule Huebris.Auth do
  @moduledoc """
  Authenticates with a Hue Bridge
  """

  alias Core.ServiceManager
  use GenServer
  require Logger

  def start_link(state \\ %{}) do
  	GenServer.start_link(__MODULE__, state, name: HuebrisAuth)
  end

  def init(state) do
  	# Schedule work to be performed at some point
  	schedule_work(state)
  	{:ok, state}
  end

  @doc """
  We will create a loop that will try to autorize the hue brisdge
  once every second. Once the the bridge is authorized the loop will exit.
  """
  def handle_info(:work, state) do

  	bridge = try_fetch(state.host, state.name)

  	if bridge.error do
  		payload = %{
  			"type" => "error",
  			"body" =>  bridge.error["description"]
  		}
  		CoreWeb.ServiceChannel.broadcast_service_message(payload)
  		# While the loop recieves errors it will continue.
  		schedule_work(state)
  	end

  	if bridge.username do
  		#if we have a bridge token we should store it in the database and start
  		#the authorized action.
  		service = ServiceManager.get_service!(state.id)
  		attrs = %{api_key: bridge.username, authorized: true}
  		ServiceManager.update_service(service, attrs)
  	end
  	{:noreply, state}
  end

  defp schedule_work(state) do
  	#We will poll the Dark Sky API every 3 minutes
  	Process.send_after(self(), :work, 1000)
    {:noreply, state}
  end

  @doc """
  Authentication method
  """
  def try_fetch(bridge, device) do
    bridge
    |> Exhue.connect(device)
  end
end
