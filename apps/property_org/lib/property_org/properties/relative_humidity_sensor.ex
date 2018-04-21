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
      description: "Percentage of relative humidity"
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
    registration_info = RelativeHumiditySensor.registration()
    unit_description = RelativeHumiditySensor.unit_description()
    value_description = RelativeHumiditySensor.value_description()

    PropertyOrg.create_registration(registration_info, unit_description, value_description)
  end
end
