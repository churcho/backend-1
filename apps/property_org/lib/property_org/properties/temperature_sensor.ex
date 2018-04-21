defmodule PropertyOrg.TemperatureSensor do
  @moduledoc """
  Defines the schema for a binary switch
  """
  require Logger
  alias PropertyOrg.TemperatureSensor

  def registration do
    %{
      name: "temperature_sensor",
      description: "A sensor that measures ambient temperature",
      type: "range",
      readOnly: true
    }
  end

  def unit_description do
    %{
      name: "temperature",
      symbols: [
        "F",
        "C",
        "K"
      ],
      description: "Temperature Standard"
    }
  end

  def value_description do
    %{
      type: "range",
      min: -1000,
      max:  2000
    }
  end

  @doc """
  Register the provider
  """


  def register_property do
    registration_info = TemperatureSensor.registration()
    unit_description = TemperatureSensor.unit_description()
    value_description = TemperatureSensor.value_description()

    PropertyOrg.create_registration(registration_info, unit_description, value_description)
  end
end
