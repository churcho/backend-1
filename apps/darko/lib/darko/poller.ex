defmodule Darko.Poller do
  @moduledoc """
  Polling the darksky service to update your virutal westher stations.
  """

  @doc """
  Simple function to grab the latest weather and update a corresponding station
  """
  def poll(entity) do
    IO.puts "Connecting to DarkSky"
    server_state = fetch_currently(entity.configuration)

    net_state = %{
      temperature: server_state["currently"]["temperature"],
      humidity: server_state["currently"]["humidity"]
    }
    IO.puts "Net State"
    IO.inspect net_state.temperature
    target = Core.Repo.get_by(Core.Entity, uuid: entity.uuid)

    IO.puts "Target State"
    IO.inspect target.state

    if net_state != target.state do

        if net_state.temperature != target.state["temperature"]  do
          cond do
             net_state.temperature > target.state["temperature"] ->
              if net_state.temperature - target.state["temperature"] > 0.5 do
                 type = "temperature"
                 build_item(target, net_state.temperature, type)
              end
            target.state["temperature"] > net_state.temperature ->
              if target.state["temperature"] - net_state.temperature > 0.5 do
                 type = "temperature"
                 build_item(target, net_state.temperature, type)
              end
          end 
        end

        if net_state.humidity != target.state["humidity"] do
          type = "humidity"
          build_item(target, net_state.humidity, type)
        end
    end

  end

  def fetch_currently(station) do
     {:ok, result} = Darko.Server.forecast(station["latitude"], station["longitude"], station["access_token"])
     result
   end

  def build_item(target, value, type) do
    IO.puts "-----------------------------------------------------------"
    IO.puts                      "Updating State"
    IO.puts "-----------------------------------------------------------"
    event = %{
      entity: target.uuid,
      value: value,
      date: Ecto.DateTime.utc,
      type: type,
      source: "poll"
    }
    IO.puts "-----------------------------------------------------------"

    update_state(event, target)
    broadcast_change(event)
  end


  def update_state(event, target) do
    new_state =
    if target.state != nil do
      %{state: Map.put(target.state, event.type, event.value)}
    else
      %{state: %{ event.type => event.value}}
    end

    IO.inspect new_state

    if new_state != nil do
      changeset = Core.Entity.changeset(target, new_state)
      Core.Repo.update!(changeset)
    end

  end

  def broadcast_change(event) do
    new_event = %Core.Event{entity: event.entity, 
                            value: to_string(event.value), 
                            date: event.date, 
                            type: event.type, 
                            source: event.source,
                            message: "test"}
    
    case Core.Repo.insert(new_event) do
      {:ok, event} ->
         Core.EventChannel.broadcast_change(event)

    end
   
  end
end