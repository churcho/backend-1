defmodule Zedwave.Handler.EcolinkMotion do
  @moduledoc """
    Device Handler for Ecolink Motion Sensor
  """

  alias Core.EntityManager
  alias Core.PropertyManager

  def return_type(node, service) do
    type = EntityManager.get_entity_type_by_name("default_type")

    entity = %{
      service_id: service.id,
      entity_type_id: type.id,
      uuid: node["_id"],
      name: node["product"],
      source: "zedwave",
      description: node["type"]
    }

    {:ok, new_entity} = EntityManager.create_or_update_entity(entity)

    # Motion Sensor
    motion = PropertyManager.get_property_by_name("motion_sensor")

    motion_property = %{
      property_id: motion.id,
      entity_id: new_entity.id,
      name: build_name("motion_sensor", new_entity.id, motion.id),
      label: "Motion Sensor",
      state: %{
        value: node["classes"]["48"]["0"]["value"]
      }
    }

    create_prop(motion_property)

    # Battery Level Sensor
    battery = PropertyManager.get_property_by_name("battery_level_sensor")

    battery_property = %{
      property_id: battery.id,
      entity_id: new_entity.id,
      name: build_name("battery_level", new_entity.id, battery.id),
      label: "Battery Level",
      state: %{
        value: node["classes"]["128"]["0"]["value"]
      }
    }

    create_prop(battery_property)
  end

  def build_name(name_text, entity, property) do
    "#{name_text}_#{entity}_#{property}"
  end

  def create_prop(prop) do
    {:ok, new_prop} = EntityManager.create_or_update_property_type(prop)
    new_prop
  end
end
