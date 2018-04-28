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
    registration_info = BinaryAccessControlSensor.registration()
    PropertyOrg.create_registration(registration_info)
  end
end
