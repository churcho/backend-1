defmodule Huebris.Importer do
  @moduledoc """
  Manages import of Hue devices.
  """

  alias Core.ServiceManager

  @doc """
  Update funcntion takes a services and builds a service import object
  """
  def update(service) do
    IO.puts "Importing devices on ------"

    lights = Huebris.connect(service.host, service.api_key)
    lights
  	|> Huebris.getlights

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
  end
end
