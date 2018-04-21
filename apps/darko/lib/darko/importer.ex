defmodule Darko.Importer do
  @moduledoc """
  Importer Module
  """
  alias Core.EntityManager
  alias Core.LocationManager

  def update(service) do
    locations = LocationManager.list_locations

    for location <- locations do
      station_id = "darko_" <> Integer.to_string(location.id)
      target =  %{
        uuid: station_id,
        name: "Weather Station for " <> location.name,
        service_id: service.id,
        display_name: "Weather Station",
        source_event: "IMPORT",
        source: "Darko",
        configuration: %{
          commands: [],
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
      EntityManager.create_or_update_entity(target)
  end
end
