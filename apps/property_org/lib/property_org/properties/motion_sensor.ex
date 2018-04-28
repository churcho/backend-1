defmodule PropertyOrg.MotionSensor do
  @moduledoc """
  Defines the schema for a motion switch
  """
  require Logger
  alias PropertyOrg.MotionSensor

  def registration do
    %{
      name: "motion_sensor",
      description: "A sensor that measures two states of a motion sensor",
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
    registration_info = MotionSensor.registration()
    PropertyOrg.create_registration(registration_info)
  end
end
