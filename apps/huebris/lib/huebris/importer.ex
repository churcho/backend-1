defmodule Huebris.Importer do
  @moduledoc """
  Manages import of Hue devices.
  """
  require Logger
  alias Core.ServiceManager

  @doc """
  Update funcntion takes a services and builds a service import object
  """
  def update(service) do
    lights = Huebris.Client.connect(service.host, service.api_key)
    lights
  	|> Huebris.Client.getlights

  	for {key, value} <- lights do

  		target = %{
  			uuid: value["uniqueid"],
  			service_id: service.id,
        state: %{
          level: nil,
          switch: ""
        },
  			name: value["name"],
  			metadata: %{
  				manufacturername: value["manufacturername"],
  				modelid: value["modelid"],
  				hue_id: key
  			}
  		}

  		import_entity(target)
  	end
  end

  @doc """
  Imports the service entity created by the update function
  """
  def import_entity(target) do
     	ServiceManager.create_or_update_entity(target)
      Logger.info fn ->
        "Entity imported by hue"
      end
  end
end
