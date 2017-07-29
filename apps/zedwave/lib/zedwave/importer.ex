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

    IO.puts "Entities"



  	for entity <- entities do

      IO.puts entity["_id"]
      IO.inspect entity


  		target = %{
  			uuid:  entity["_id"],
  			service_id: service.id,

  			name: name_it(entity),
  			metadata: %{
          manufacturer: entity["manufacturer"]
  			}
  		}
      IO.inspect target
  		import_entity(target)
  	end
  end

  def build_item(target) do
  	event = %{
        uuid: target.uuid,
    	  value: "IMPORT",
    	  date: to_string(Ecto.DateTime.utc),
    	  type: "SERVICE",
    	  source: "Zedwave",
    	  service_id: target.service_id,
    	  entity_id: target.id,
    	  source_event: "IMPORT",
    	  message: "Service Imported",
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
      #build_item(entity)
    end
  end


  defp name_it(entity) do
    if entity["name"] != "" do
      entity["name"]
    else
      entity["product"]
    end
  end
end
