defmodule PropertyOrg do
  @moduledoc """
  Property Org implementation.
  """
  require Logger

  alias Core.PropertyManager
  alias Core.PropertyManager.BooleanProperty
  alias Core.PropertyManager.RangeProperty

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

  def create_registration(registration_info) do
    case registration_info.type do
      "boolean" ->
        with {:ok, %BooleanProperty{} = boolean_property} <-
          PropertyManager.create_or_update_boolean_property(registration_info) do
            Logger.info(fn ->
              "Boolean Property Registered as #{boolean_property.name}"
            end)
        end
      "range" ->
        with {:ok, %RangeProperty{} = range_property} <-
          PropertyManager.create_or_update_range_property(registration_info) do
            Logger.info(fn ->
              "Range Property Registered as #{range_property.name}"
            end)
          end
      _ ->
        false
    end
  end
end
