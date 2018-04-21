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
      readOnly: true
    }
  end

  @doc """
  Register the provider
  """
  def unit_description do
    %{
      name: "none",
      symbols: [
      ],
      description: "none"
    }
  end

  def value_description do
    %{
      type: "bool",
      values: [
        true,
        false
      ]
    }
  end

  @doc """
  Register the provider
  """


  def register_property do
    registration_info = MotionSensor.registration()
    unit_description = MotionSensor.unit_description()
    value_description = MotionSensor.value_description()

    PropertyOrg.create_registration(registration_info, unit_description, value_description)
  end
end
