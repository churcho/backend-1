defmodule Zedwave.Importer do
  @moduledoc """
  Manages import of Hue devices.
  """
  require Logger
  alias Core.EventManager
  alias CoreWeb.EventChannel
  alias Core.ServiceManager

  @doc """
  Update funcntion takes a services and builds a service import object
  """
  def update(service) do
    entities = Zedwave.Client.get_entities(service.host)

  	for entity <- entities do
      new_state =
        if entity["lorpState"] do
          entity["lorpState"]
        else
          %{}
        end

  		target = %{
  			uuid:  entity["_id"],
  			service_id: service.id,
        configuration: %{
          commands: get_command_set(entity),
        },
  			name: name_it(entity),
        capabilities: set_capabilities(entity),
        state: new_state,
  			metadata: %{
          manufacturer: entity["manufacturer"]
  			}
  		}
  		import_entity(target)
  	end
  end

  def build_item(target) do
    IO.puts "Notify of import"
    IO.inspect target
  	event = %{
        uuid: target.uuid,
    	  value: "IMPORT",
    	  date: to_string(Ecto.DateTime.utc),
    	  type: "SERVICE",
    	  source: "Zedwave",
    	  service_id: target.service_id,
    	  entity_id: target.id,
    	  source_event: "IMPORT",
    	  message: "Entity Imported",
    	  metadata: %{}
  	}

  	broadcast_change(event)
  end

  def broadcast_change(event) do
  	{:ok, event} = EventManager.create_event(event)
    EventChannel.broadcast_change(event)
  end
  @doc """
  Imports the service entity created by the update function
  """
  def import_entity(target) do

    {:ok, entity} =
    ServiceManager.create_or_update_entity(target)
    Logger.info fn ->
      "Entity imported by Zedwave"
    end

    if entity do
      target = entity |> Core.Repo.preload([:service])
      Zedwave.Client.update_imported_entity(target.service.host, target)
      build_item(entity)
    end
  end

  defp get_command_set(entity) do
    name = name_it(entity)
    case name do
      "PIR Motion Sensor" ->
        [%{command: "poll", name: "Poll"}]
      "Door/Window Sensor" ->
        [%{command: "poll", name: "Poll"}]
      "ZW120 Door Window Sensor Gen5" ->
        [%{command: "poll", name: "Poll"}]
      "ZW090 Z-Stick Gen5" ->
        [%{command: "poll", name: "Poll"},
         %{command: "add", name: "Inclusion Mode"},
         %{command: "remove", name: "Exclusion Mode"}]
      _ ->
        []
    end
  end

  defp set_capabilities(entity) do
    name = name_it(entity)
    case name do
      "PIR Motion Sensor" ->
        ["MOTION_DETECTION"]
      "Door/Window Sensor" ->
        ["CONTACT_SENSOR"]
      "ZW120 Door Window Sensor Gen5" ->
        ["CONTACT_SENSOR"]
      "ZW090 Z-Stick Gen5 US" ->
        ["CONTROLLER"]
      "ZW096 Smart Switch 6" ->
        ["SWITCH"]
      _ ->
        []
    end
  end

  defp name_it(entity) do
    if entity do
      if entity["name"] == "" or entity["name"] == nil do
        if entity["product"] do
          if entity["product"] != "" or entity["product"] != nil do
            entity["product"]
          else
            "default"
          end
        else
          "default"
        end
      end
    end
  end
end
