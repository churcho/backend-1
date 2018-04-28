defmodule PropertyOrg.BinarySwitch do
  @moduledoc """
  Defines the schema for a binary switch
  """
  require Logger
  alias PropertyOrg.BinarySwitch

  def registration do
    %{
      name: "binary_switch",
      description: "A swtich that has two states: On or Off",
      type: "boolean",
      readOnly: false,
      value: %{
        enum_type: [
          true,
          false
        ]
      }
    }
  end

  @doc """
  Register the property
  """
  def register_property do
    registration_info = BinarySwitch.registration()
    PropertyOrg.create_registration(registration_info)
  end
end
