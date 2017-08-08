defmodule Darko.Poller do
  require Logger
  alias Core.ServiceManager
  alias Core.EventManager
  alias Core.ServiceManager
  alias Core.ServiceManager.Entity
  alias CoreWeb.EventChannel

  @moduledoc """
  Polling the darksky service to update your virutal weather stations.
  """

  @doc """
  Simple function to grab the latest weather and update a corresponding station
  """
  def poll(entity) do
    Logger.info fn ->
       "Connecting to DarkSky"
    end
    server_state = fetch_currently(entity.configuration)


    numeric_items = ["ozone",
                      "temperature",
                      "humidity",
                      "dewPoint",
                      "cloudCover",
                      "pressure"]
    text_items = ["summary", "icon"]

    net_state = %{
      "summary" =>server_state["currently"]["summary"],
      "ozone" => server_state["currently"]["ozone"],
      "icon" => server_state["currently"]["icon"],
      "dewPoint" => server_state["currently"]["dewPoint"],
      "pressure" => server_state["currently"]["pressure"],
      "temperature" => server_state["currently"]["temperature"],
      "humidity" => server_state["currently"]["humidity"],
      "cloudCover" => server_state["currently"]["cloudCover"]
    }


     target = ServiceManager.get_entity_by_uuid(entity.uuid)



    if net_state != target.state do
      update_state(target, net_state)

      for measurement <- numeric_items do
        if net_state[measurement] != target.state[measurement] do
          type = measurement
          build_item(target, net_state[measurement], type)
        end
      end


      for measurement <- text_items do
        if net_state[measurement] != target.state[measurement] do
          type = measurement
          build_item(target, net_state[measurement], type)
        end
      end
    end
  end

  def fetch_currently(station) do
    {:ok, result} = Darko.Client.forecast(station["latitude"], station["longitude"], station["api_key"])
    Logger.info fn ->
      "Fetching current weather"
    end
    result
  end


  def update_state(entity, net_state) do
    new_state =
    if entity.state != nil do
      %{state: Map.merge(entity.state, net_state)}
    else
      %{state: net_state}
    end


    with {:ok, %Entity{} = entity} <- ServiceManager.update_entity(entity, new_state) do
      entity
    end
  end



  def build_item(target, value, type) do
    event = %{
      uuid: target.uuid,
      value: to_string(value),
      date: to_string(Ecto.DateTime.utc),
      type: type,
      source: "Darko",
      service_id: target.service_id,
      entity_id: target.id,
      source_event: "POLL",
      message: "Polling for changes",
      metadata: %{}
    }

    broadcast_change(event)
  end

  def broadcast_change(event) do
  	{:ok, new_event} = EventManager.create_event(event)
    new_event
    |> EventChannel.broadcast_change
  end
end
