defmodule Darko.Importer do
  import Ecto.Query
  alias Core.Repo
  alias Core.ServiceManager
  alias Core.LocationManager

  def import(service) do
    locations = LocationManager.list_locations

    for location <- locations do
      station_id = "darko_"<>Integer.to_string(location.id)
      target =  %{
        uuid: station_id,
        name: "Weather Station for "<>location.name,
        service_id: service.id,
        display_name: "Weather Station",
        source: "Darko",
        configuration: %{
          location_id: location.id,
          longitude: location.longitude,
          latitude: location.latitude,
          api_key: service.api_key
        } 
      }

      import_entity(target)
    end
  end

  def import_entity(target) do
      ServiceManager.create_or_update_entity(target)
  end
end