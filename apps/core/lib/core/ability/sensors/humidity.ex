defmodule Core.Ability.Sensors.RelativeHumidity do
  @moduledoc """
  Defines the schema and model of a temperature sensor
  """

  defstruct [
    name: "Core.Ability.Sensors.RelativeHumidity",
    label: nil,
    properties: %{
      relative_humidity: %{
        type: "number",
        description: "Current measured relative humidity"
      },
      units: %{
        type: "string",
        enum: ["%", "percent"]
      }
    },
    state: %{
      relative_humidity: nil,
      units: nil
    }
  ]
end
