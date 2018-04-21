defmodule Huebris.Importer do
  @moduledoc """
  Manages import of Hue devices.
  """
  require Logger
  alias Core.EntityManager
  alias Huebris.Client
  @doc """
  Update funcntion takes a services and builds a service import object
  """
  def update(service) do
    lights =
    Huebris.Client.connect(service.host, service.api_key)
  	|> Huebris.Client.getlights

  	for {key, value} <- lights do
      IO.inspect value["modelid"]
      IO.inspect value["state"]
  		target = %{
  			uuid: value["uniqueid"],
  			service_id: service.id,
        configuration: %{
          commands: get_command_set(value)
        },
        state: %{
          level: Client.get_brightness(value["state"]["bri"]),
          switch: Client.convert_bools(value["state"]["on"]),
          color: Client.get_colors_in_rgb(value["state"]["xy"], value["state"]["bri"])
        },
  			name: value["name"],
        capabilities: ["SWITCH", "COLOR_CONTROL", "BRIGHTNESS_CONTROL"],
  			metadata: %{
  				manufacturername: value["manufacturername"],
  				modelid: value["modelid"],
  				hue_id: key
  			}
  		}

      IO.inspect target
  		import_entity(target)
  	end
  end

  @doc """
  Imports the service entity created by the update function
  """
  def import_entity(target) do
     EntityManager.create_or_update_entity(target)
      Logger.info fn ->
        "Entity imported by hue"
      end
  end


  defp get_command_set(entity) do

    case entity["modelid"] do

      _ ->
        [%{command: "on", name: "Turn On"},
         %{command: "off", name: "Turn Off"}]
    end
  end


end
