defmodule Core.EntityManager.CommandTemplates do
  @moduledoc """
  Create intial attributes
  """

  def return_list do
    [
      %{
        title: "Turn On",
        action: "turn_on",
        event: "turned_on",
        event_success_message: "was turned on.",
        event_error_message: "failed to turn on.",
        action_arguments: [
          %{
            name: "component_id",
            type: "uuid",
            required: true,
            index: 0
          }
        ]
      },
      %{
        title: "Turn Off",
        action: "turn_off",
        event: "turned_off",
        event_success_message: "was turned off.",
        event_error_message: "failed to turn off.",
        action_arguments: [
          %{
            name: "component_id",
            type: "uuid",
            required: true,
            index: 0
          }
        ]
      },
      %{
        title: "Set Brightness",
        action: "set_brightness",
        event: "brightness_set",
        event_success_message: "Brightness was set",
        event_error_message: "Faled to set brightness.",
        action_arguments: [
          %{
            name: "component_id",
            type: "uuid",
            required: true,
            index: 0
          },
          %{
            name: "brightness",
            type: "integer",
            required: true,
            index: 1
          }
        ]
      },
      %{
        title: "Set Color",
        action: "set_color",
        event: "color_set",
        event_success_message: "Color was set",
        event_error_message: "Faled to set color.",
        action_arguments: [
          %{
            name: "component_id",
            type: "uuid",
            required: true,
            index: 0
          },
          %{
            name: "rgb",
            type: "array",
            required: true,
            index: 1
          }
        ]
      }

    ]
  end
end
