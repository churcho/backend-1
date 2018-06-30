defmodule Core.Places.Projectors.Zone do
  @moduledoc false
  use Commanded.Projections.Ecto,
    name: "Places.Projectors.Zone",
    consistency: :strong

  alias Core.Places.Events.{
    ZoneCreated,
    ZoneDeleted,
    ZoneNameChanged,
    ZoneDescriptionChanged,
    ZoneLocationChanged

  }
  alias Core.Places.Projections.Zone
  alias Ecto.Multi

  project %ZoneCreated{} = created do
    Multi.insert(multi, :zone, %Zone{
      uuid: created.zone_uuid,
      name: created.name,
      description: created.description,
      location_uuid: created.location_uuid
    })
  end

  project %ZoneNameChanged{zone_uuid: zone_uuid, name: name} do
    update_zone(multi, zone_uuid, name: name)
  end

  project %ZoneDescriptionChanged{
    zone_uuid: zone_uuid,
    description: description
    }
  do
    update_zone(multi, zone_uuid, description: description)
  end

  project %ZoneLocationChanged{
    zone_uuid: zone_uuid,
    location_uuid: location_uuid
    }
  do
    update_zone(multi, zone_uuid, location_uuid: location_uuid)
  end

  project %ZoneDeleted{zone_uuid: zone_uuid} do
    Multi.delete_all(multi, :zone, zone_query(zone_uuid))
  end

  defp update_zone(multi, zone_uuid, changes) do
    Multi.update_all(
      multi, :zone, zone_query(zone_uuid), set: changes
      )
  end

  defp zone_query(zone_uuid) do
    from(r in Zone, where: r.uuid == ^zone_uuid)
  end
end
