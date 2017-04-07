defmodule Huebris.Poller do
  @moduledoc """
  Polls the hue bridge for changes to state.
  """

  alias Core.EventManager
  alias Core.EventManager.Event
  alias Core.ServiceManager

  @doc """
  Poll a bridge entity for changes
  """
  def poll(service) do

  	lights = Huebris.connect(service.host, service.api_key)

    lights
  	|> Huebris.getlights

  	for {key, value} <- lights do

  		target = ServiceManager.get_entity_by_uuid(value["uniqueid"])
  		net_state = %{
  			"level" => value["state"]["bri"],
  			"switch" => convert_bools(value["state"]["on"])
  		}

  		if net_state != target.state do
  			update_state(target, net_state)

  			for {key, value} <- net_state do
  				if value != target.state[key] do
  					build_item(target, value, key)
  				end
  			end
  		end


  	end
  end


  def update_state(target, net_state) do
  	new_state =
  	if target.state != nil do
    		%{state: Map.merge(target.state, net_state)}
  	else
    		%{state: net_state}
  	end

  	if new_state != nil do
  		ServiceManager.update_entity(target, new_state)
  	end

  end

  def build_item(target, value, type) do
  	event = %{
  	  uuid: target.uuid,
  	  value: to_string(value),
  	  date: to_string(Ecto.DateTime.utc),
  	  type: type,
  	  source: "Huebris",
  	  service_id: target.service_id,
  	  entity_id: target.id,
  	  source_event: "POLL",
  	  message: "Polling for changes",
  	  metadata: %{}
  	}

  	broadcast_change(event)
  end

  def broadcast_change(event) do
  	with {:ok, %Event{} = event} <- EventManager.create_event(event) do
      event
  	 
  	end
  end


  defp convert_bools(bool) do
  	case bool do
  		true ->
  			"on"
  		false ->
  			"off"
  		_ ->
  			"Unknow"
   	end
  end
end
