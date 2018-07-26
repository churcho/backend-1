defmodule Core.EntityManager.AttributeTemplates do
  @moduledoc """
  Create intial attributes
  """

  def return_list do
    [
      %{
        name: "temperature_measurement",
        descritpion: "Measures ambient temperature",
        type: "float",
        units: [
          "F",
          "C",
          "K"
        ],
        min: -10_000,
        max: 10_000,
        read_only: true
      },
      %{
        name: "humidity_measurement",
        description: "Measures relative humidity",
        type: "float",
        units: [
          "%"
        ],
        min: 0,
        max: 100,
        read_only: true
      }
    ]
  end
end
