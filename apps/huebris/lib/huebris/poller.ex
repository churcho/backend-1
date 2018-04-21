defmodule Huebris.Poller do
  @moduledoc """
  Polls the hue bridge for changes to state.
  """

  alias Core.EventManager
  alias CoreWeb.EventChannel
  alias Core.EntityManager
  alias Huebris.Client
  @doc """
  Poll a bridge entity for changes
  """
  def poll(current_bridge, new_bridge) do
    lights = new_bridge

  	for {key, value} <- lights do

      state_match = Huebris.Server.state_check(value, current_bridge[key])

      if state_match == false do
        IO.puts "states need a sync"
        target = EntityManager.get_entity_by_uuid(value["uniqueid"])
        net_state = %{
         "level" => Client.get_brightness(value["state"]["bri"]),
         "switch" => Client.convert_bools(value["state"]["on"]),
         "color" => Client.get_colors_in_rgb(value["state"]["xy"], value["state"]["bri"])
        }

        update_state(target, net_state)
        for {key, value} <- net_state do
          if value != target.state[key] do
            build_item(target, value, key)
          end
        end
      end
      Huebris.Server.load_bridges(new_bridge)
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
  		EntityManager.update_entity(target, new_state)
  	end

  end

  def build_item(target, value, type) do
  	event = %{
        uuid: target.uuid,
    	  value: parse_value(value),
    	  date: to_string(Ecto.DateTime.utc),
    	  type: type,
    	  source: "Huebris",
    	  service_id: target.service_id,
    	  entity_id: target.id,
    	  source_event: "POLL",
    	  message: "Polling for changes",
    	  metadata: %{}
  	}
    IO.puts "BROADCAST!!!!!"
  	broadcast_change(event)
  end

  def broadcast_change(event) do
  	{:ok, event} = EventManager.create_event(event)
    EventChannel.broadcast_change(event)
  end

  defp parse_value(value) do
    if is_list(value) do
      "changed"
    else
      to_string(value)
    end
  end



end
