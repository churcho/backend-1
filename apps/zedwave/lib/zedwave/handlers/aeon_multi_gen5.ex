defmodule Zedwave.Handler.AeonMultiGen5 do
  @moduledoc """
    Device Handler for Ecolink Motion Sensor
  """
  alias Core.EntityManager
  alias Core.PropertyManager
  alias Core.ServiceManager

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
      label: "Motion Sensor",
      name: build_name("motion_sensor", new_entity.id, motion.id),
      state: %{
        value: parse_motion(node["classes"]["113"]["10"]["value"])
      }
    }

    create_prop(motion_property)

    # Humidity Sensor
    humidity = PropertyManager.get_property_by_name("relative_humidity_sensor")

    humidity_property = %{
      property_id: humidity.id,
      entity_id: new_entity.id,
      label: "Humidity Sensor",
      name: build_name("humidity_sensor", new_entity.id, humidity.id),
      state: %{
        value: node["classes"]["49"]["5"]["value"]
      }
    }

    create_prop(humidity_property)

    # Illuminance Sensor
    illum = PropertyManager.get_property_by_name("illuminance_sensor")

    illum_property = %{
      property_id: illum.id,
      entity_id: new_entity.id,
      label: "Illuminance Sensor",
      name: build_name("illuminance_sensor", new_entity.id, illum.id),
      state: %{
        value: node["classes"]["49"]["3"]["value"]
      }
    }

    create_prop(illum_property)

    # Battery Level Sensor
    battery = PropertyManager.get_property_by_name("battery_level_sensor")

    battery_property = %{
      property_id: battery.id,
      entity_id: new_entity.id,
      label: "Battery Level",
      name: build_name("battery_level", new_entity.id, battery.id),
      state: %{
        value: node["classes"]["128"]["0"]["value"]
      }
    }

    create_prop(battery_property)
  end

  def create_prop(prop) do
    {:ok, new_prop} = ServiceManager.create_or_update_property_type(prop)
    new_prop
  end

  def parse_motion(prop) do
    if prop == 8 do
      true
    else
      false
    end
  end

  def build_name(name_text, entity, property) do
    "#{name_text}_#{entity}_#{property}"
  end
end
