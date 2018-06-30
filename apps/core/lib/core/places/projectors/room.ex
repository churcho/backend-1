defmodule Core.Places.Projectors.Room do
  @moduledoc false
  use Commanded.Projections.Ecto,
    name: "Places.Projectors.Room",
    consistency: :strong

  alias Core.Places.Events.{
    RoomCreated,
    RoomDeleted,
    RoomNameChanged,
    RoomDescriptionChanged,
    RoomZoneChanged
  }
  alias Core.Places.Projections.Room
  alias Ecto.Multi

  project %RoomCreated{} = created do
    Multi.insert(multi, :room, %Room{
      uuid: created.room_uuid,
      name: created.name,
      description: created.description,
      zone_uuid: created.zone_uuid
    })
  end

  project %RoomNameChanged{room_uuid: room_uuid, name: name} do
    update_room(multi, room_uuid, name: name)
  end

  project %RoomDescriptionChanged{
    room_uuid: room_uuid,
    description: description
    }
  do
    update_room(multi, room_uuid, description: description)
  end

  project %RoomZoneChanged{
    room_uuid: room_uuid,
    zone_uuid: zone_uuid
    }
  do
    update_room(multi, room_uuid, zone_uuid: zone_uuid)
  end

  project %RoomDeleted{room_uuid: room_uuid} do
    Multi.delete_all(multi, :room, room_query(room_uuid))
  end

  defp update_room(multi, room_uuid, changes) do
    Multi.update_all(
      multi, :room, room_query(room_uuid), set: changes
      )
  end

  defp room_query(room_uuid) do
    from(r in Room, where: r.uuid == ^room_uuid)
  end
end
