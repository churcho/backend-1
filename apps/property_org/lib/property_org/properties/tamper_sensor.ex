defmodule PropertyOrg.TamperSensor do
  @moduledoc """
  Defines the schema for a tamper sensor
  """
  require Logger
  alias PropertyOrg.TamperSensor

  def registration do
    %{
      name: "tamper_sensor",
      description: "A sensor that measures two states of a tamper control sensor",
      type: "boolean",
      readOnly: true
    }
  end

  @doc """
  Register the provider
  """
  def unit_description do
    %{
      name: "none",
      symbols: [
      ],
      description: "none"
    }
  end

  def value_description do
    %{
      type: "bool",
      values: [
        true,
        false
      ]
    }
  end

  @doc """
  Register the provider
  """


  def register_property do
    registration_info = TamperSensor.registration()
    unit_description = TamperSensor.unit_description()
    value_description = TamperSensor.value_description()

    PropertyOrg.create_registration(registration_info, unit_description, value_description)
  end
end
