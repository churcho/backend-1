defmodule PropertyOrg.BinaryAccessControlSensor do
  @moduledoc """
  Defines the schema for a binary switch
  """
  require Logger
  alias PropertyOrg.BinaryAccessControlSensor

  def registration do
    %{
      name: "binary_access_control_sensor",
      description: "A sensor that measures two states of an access control sensor",
      type: "boolean",
      readOnly: true
    }
  end

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
    registration_info = BinaryAccessControlSensor.registration()
    unit_description = BinaryAccessControlSensor.unit_description()
    value_description = BinaryAccessControlSensor.value_description()

    PropertyOrg.create_registration(registration_info, unit_description, value_description)
  end
end
