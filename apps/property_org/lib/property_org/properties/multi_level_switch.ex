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
      readOnly: false,
      value: %{
        min: 0,
        max: 100
       },
       unit: %{
         name: "Switch Level",
         symbols: [
           "%"
         ]
       }
    }
  end

  @doc """
  Register the provider
  """
  def register_property do
    registration_info = MultiLevelSwitch.registration()
    PropertyOrg.create_registration(registration_info)
  end
end
