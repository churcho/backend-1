defmodule Core.Registry.Templates.CommandTemplate do
  @moduledoc """
  Create intial attributes
  """

  def return_list do
    [
      %{
        title: "Turn On",
        action: "turn_on",
        action_arguments: [
          %{
            name: "component_id",
            type: "uuid",
            required: true,
            index: 0
          }
        ],
        action_events: [
          %{
            result_state: "success",
            message: "was turned on."
          },
          %{
            result_state: "error",
            message: "error"
          }
        ]
      },
      %{
        title: "Turn Off",
        action: "turn_off",
        action_arguments: [
          %{
            name: "component_id",
            type: "uuid",
            required: true,
            index: 0
          }
        ],
        action_events: [
          %{
            result_state: "success",
            message: "was turned off."
          },
          %{
            result_state: "error",
            message: "error"
          }
        ]
      },
      %{
        title: "Set Brightness",
        action: "set_brightness",
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
        ],
        action_events: [
          %{
            result_state: "success",
            message: "Brightness was set."
          },
          %{
            result_state: "error",
            message: "error"
          }
        ]
      },
      %{
        title: "Set Color",
        action: "set_color",
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
        ],
        action_events: [
          %{
            result_state: "success",
            message: "Color was set."
          },
          %{
            result_state: "error",
            message: "error"
          }
        ]
      }

    ]
  end
end
