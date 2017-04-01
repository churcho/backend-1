defmodule Darko.Importer do
  import Ecto.Query
  alias Core.Repo
  alias Core.Entity

  def import(service) do
    locations = Core.Repo.all(Core.Location)

    for location <- locations do
      station_id = "darko_"<>Integer.to_string(location.id)
    	result = Core.Repo.get_by(Core.Entity, uuid: station_id)
  

      changeset =  %{
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

      result = 
      case Repo.get_by(Entity, uuid: station_id) do
        nil -> Entity.changeset(%Entity{}, changeset)
        entity -> Entity.changeset(entity, changeset)
      end
      |> Repo.insert_or_update

    end
  end
end