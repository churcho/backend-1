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
      readOnly: true,
      value: %{
        min: 0,
        max: 100
       },
       unit: %{
         name: "Temperature",
         symbols: [
           "F",
           "C",
           "K"
         ]
       }
    }
  end

  @doc """
  Register the provider
  """

  def register_property do
    registration_info = TemperatureSensor.registration()
    PropertyOrg.create_registration(registration_info)
  end
end
