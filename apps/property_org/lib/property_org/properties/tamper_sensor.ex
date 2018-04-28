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
      readOnly: true,
      value: %{
        enum_type: [
          true,
          false
        ]
      }
    }
  end


  @doc """
  Register the provider
  """


  def register_property do
    registration_info = TamperSensor.registration()
    PropertyOrg.create_registration(registration_info)
  end
end
