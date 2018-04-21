defmodule PropertyOrg do
  @moduledoc """
  Property Org implementation.
  """
  require Logger

  alias Core.PropertyManager
  alias Core.PropertyManager.Property

  alias PropertyOrg.BinarySwitch
  alias PropertyOrg.BinaryAccessControlSensor
  alias PropertyOrg.BatteryLevelSensor
  alias PropertyOrg.IlluminanceSensor
  alias PropertyOrg.MotionSensor
  alias PropertyOrg.MultiLevelSwitch
  alias PropertyOrg.RelativeHumiditySensor
  alias PropertyOrg.TamperSensor
  alias PropertyOrg.TemperatureSensor

  def register do
    # Switch Controls
    BinarySwitch.register_property()
    MultiLevelSwitch.register_property()

    # Envrionmental Sensors
    IlluminanceSensor.register_property()
    MotionSensor.register_property()
    RelativeHumiditySensor.register_property()
    TemperatureSensor.register_property()

    # Access Control Sensors
    BinaryAccessControlSensor.register_property()

    # Device Sensors
    BatteryLevelSensor.register_property()
    TamperSensor.register_property()
  end

  def create_registration(registration_info, unit_description, value) do
    with {:ok, %Property{} = property} <-
       PropertyManager.create_or_update_property(registration_info) do
        Logger.info(fn ->
          "Property Registered as #{property.name}"
        end)

      prop = PropertyManager.preload_property_assoc(property)

      new_val = value_parser(prop, value)
      if Map.has_key?(new_val, :id) do
        IO.puts "UPDATE VALUE"
        IO.inspect new_val
        case new_val.type do
          "bool" ->
            PropertyManager.update_bool_value(prop.bool_value, new_val)
          "range" ->
            PropertyManager.update_range_value(prop.range_value, new_val)
        end
      else
        IO.puts "CREATE VALUE"
        IO.inspect new_val
        case new_val.type do
          "bool" ->
            PropertyManager.create_bool_value(new_val )
          "range" ->
            PropertyManager.create_range_value(new_val)
        end
      end

      info = unit_description
      unit =
      if prop.unit do
        %{
          id: prop.unit.id,
          property_id: property.id,
          name: info.name,
          description: info.description,
          symbols: info.symbols
        }
      else
        %{
          property_id: property.id,
          name: info.name,
          description: info.description,
          symbols: info.symbols
        }
      end

      if Map.has_key?(unit, :id) do
        PropertyManager.update_unit(prop.unit, unit)
      else
        PropertyManager.create_unit(unit)
      end

      Logger.info(fn ->
        "Unit Registered for #{property.name}"
      end)

    end
  end


  def value_parser(property, value) do
    case value.type do
      "bool" ->
        if property.bool_value  do
          %{
            type: "bool",
            property_id: property.id,
            id: property.bool_value.id,
            values: value.values
          }
        else
          %{
            type: "bool",
            property_id: property.id,
            values: value.values
          }
        end

      "range" ->
        if property.range_value do
          %{
            type: "range",
            property_id: property.id,
            id: property.range_value.id,
            min: value.min,
            max: value.max
          }
        else
          %{
            type: "range",
            property_id: property.id,
            min: value.min,
            max: value.max
          }
        end

      _ ->
        nil
    end
  end
end
