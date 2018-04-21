defmodule PropertyOrg.IlluminanceSensor do
  @moduledoc """
  Defines the schema for an illuminance sensor
  """
  require Logger
  alias PropertyOrg.IlluminanceSensor

  def registration do
    %{
      name: "illuminance_sensor",
      description: "A sensor that measures illuminance",
      type: "range",
      readOnly: false
    }
  end

  def unit_description do
    %{
      name: "lux",
      symbols: [
        "lux"
      ],
      description: "Illumation value in measured in lux"
    }
  end

  def value_description do
    %{
      type: "range",
      min: 0,
      max: 100_000
    }
  end

  @doc """
  Register the provider
  """


  def register_property do
    registration_info = IlluminanceSensor.registration()
    unit_description = IlluminanceSensor.unit_description()
    value_description = IlluminanceSensor.value_description()

    PropertyOrg.create_registration(registration_info, unit_description, value_description)
  end
end
