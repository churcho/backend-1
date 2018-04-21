defmodule PropertyOrg.MultiLevelSwitch do
  @moduledoc """
  Defines the schema for a binary switch
  """
  require Logger
  alias PropertyOrg.MultiLevelSwitch

  def registration do
    %{
      name: "multi_level_switch",
      description: "A variable switch that can have setting from 0-100",
      type: "range",
      readOnly: false
    }
  end

  def unit_description do
    %{
      name: "level",
      symbols: [
        "%"
      ],
      description: "Light level"
    }
  end

  def value_description do
    %{
      type: "range",
      min: 0,
      max: 100
    }
  end

  @doc """
  Register the provider
  """


  def register_property do
    registration_info = MultiLevelSwitch.registration()
    unit_description = MultiLevelSwitch.unit_description()
    value_description = MultiLevelSwitch.value_description()

    PropertyOrg.create_registration(registration_info, unit_description, value_description)
  end
end
