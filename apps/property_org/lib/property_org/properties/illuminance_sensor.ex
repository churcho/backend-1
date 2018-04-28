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
      readOnly: false,
      value: %{
        min: 0,
        max: 100_000
       },
       unit: %{
         name: "Illuminance",
         symbols: [
           "lux"
         ]
       }
    }
  end

  @doc """
  Register the property
  """
  def register_property do
    registration_info = IlluminanceSensor.registration()
    PropertyOrg.create_registration(registration_info)
  end
end
