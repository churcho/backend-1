defmodule PropertyOrg.BatteryLevelSensor do
  @moduledoc """
  Defines the schema for a binary switch
  """

  alias PropertyOrg.BatteryLevelSensor

  def registration do
    %{
      name: "battery_level_sensor",
      description: "A sensor that can have setting from 0-100",
      type: "range",
      readOnly: false,
      value: %{
       min: 0,
       max: 100
      },
      unit: %{
        name: "Battery Level",
        symbols: ["%"]
      }
    }
  end

  def value_description do

  end

  @doc """
  Register the property
  """
  def register_property do
    registration_info = BatteryLevelSensor.registration()
    PropertyOrg.create_registration(registration_info)
  end
end
