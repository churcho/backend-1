defmodule Huebris.Importer do
  alias Core.ServiceManager

  @moduledoc """
  Manages import of Hue devices.
  """

  def update(service) do
  	lights = Huebris.connect(service.host, service.api_key)

    lights
  	|> Huebris.getlights

  	for {key, value} <- lights do

  		target = %{
  			uuid: value["uniqueid"],
  			service_id: service.id,
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

  def import_entity(target) do
     	ServiceManager.create_or_update_entity(target)
  end
end
