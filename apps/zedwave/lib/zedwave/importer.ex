defmodule Zedwave.Importer do
  @moduledoc """
  Manages import of Hue devices.
  """
  require Logger
  alias Core.EventManager
  alias CoreWeb.EventChannel
  alias Zedwave.Client
  alias Zedwave.Handler
  alias Core.EntityManager

  @doc """
  Update funcntion takes a services and builds a service import object
  """
  def update(service) do
    IO.puts("import stuff")

    nodes = Client.get_entities(service)

    for node <- nodes do
      Handler.parse_node(node, service)
    end
  end

  @doc """
  Imports the service entity created by the update function
  """
  def import_entity(target) do
    {:ok, entity} = EntityManager.create_or_update_entity(target)

    Logger.info(fn ->
      "Entity imported by Zedwave"
    end)

    if entity do
      target = entity
      Client.update_imported_entity(target.service.host, target)
      build_item(entity)
    end
  end

  def build_item(target) do
    IO.puts("Notify of import")

    event = %{
      uuid: target.uuid,
      value: "IMPORT",
      date: to_string(Ecto.DateTime.utc()),
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
end
