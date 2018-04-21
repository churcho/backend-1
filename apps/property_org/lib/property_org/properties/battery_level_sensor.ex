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
      readOnly: false
    }
  end

  def unit_description do
    %{
      name: "percentage",
      symbol: "%",
      symbols: [
        "%"
      ],
      description: "Percentage of battery remaining"
    }
  end

  def value_description do
    %{
      type: "range",
      min: 0,
      max: 100
    }
  end

  @doc """
  Register the provider
  """


  def register_property do
    registration_info = BatteryLevelSensor.registration()
    unit_description = BatteryLevelSensor.unit_description()
    value_description = BatteryLevelSensor.value_description()

    PropertyOrg.create_registration(registration_info, unit_description, value_description)
  end
end
