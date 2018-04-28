defmodule PropertyOrg.RelativeHumiditySensor do
  @moduledoc """
  Defines the schema for a binary switch
  """
  require Logger
  alias PropertyOrg.RelativeHumiditySensor

  def registration do
    %{
      name: "relative_humidity_sensor",
      description: "A sensor that measures relative humdity",
      type: "range",
      readOnly: false,
      value: %{
        min: 0,
        max: 100
       },
       unit: %{
         name: "Temperature",
         symbols: [
           "%"
         ]
       }
    }
  end

  @doc """
  Register the provider
  """
  def register_property do
    registration_info = RelativeHumiditySensor.registration()
    PropertyOrg.create_registration(registration_info)
  end
end
