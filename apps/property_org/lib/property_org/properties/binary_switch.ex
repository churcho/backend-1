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
      readOnly: false
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
    registration_info = BinarySwitch.registration()
    unit_description = BinarySwitch.unit_description()
    value_description = BinarySwitch.value_description()

    PropertyOrg.create_registration(registration_info, unit_description, value_description)
  end
end
