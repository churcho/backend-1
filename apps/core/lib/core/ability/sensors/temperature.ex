defmodule Core.Ability.Sensors.Temperature do
  @moduledoc """
  Defines the schema and model of a temperature sensor
  """

  defstruct [
    name: "Core.Ability.Sensors.Temperture",
    label: nil,
    properties: %{
      temperature: %{
        type: "number",
        description: "Current measured temperature"
      },
      units: %{
        type: "string",
        enum: ["F", "C", "K"]
      }
    },
    state: %{
      temperature: nil,
      units: nil
    }
  ]
end
