defmodule Core.Places.Aggregates.Room do
  @moduledoc false
  defstruct [
    uuid: nil,
    name: nil,
    description: nil,
    zone_uuid: nil,
    deleted?: false,
  ]

  alias Core.Places.Aggregates.Room
  alias Core.Places.Commands.{
    CreateRoom,
    UpdateRoom,
    DeleteRoom
  }

  alias Core.Places.Events.{
    RoomCreated,
    RoomDeleted,
    RoomNameChanged,
    RoomDescriptionChanged,
    RoomZoneChanged
  }

  @doc """
  Create a new Room
  """
  def execute(%Room{uuid: nil}, %CreateRoom{} = create) do
    %RoomCreated{
      room_uuid: create.room_uuid,
      name: create.name,
      description: create.description,
      zone_uuid: create.zone_uuid
    }
  end

  @doc """
  Update a room's name, description
  """
  def execute(%Room{} = room, %UpdateRoom{} = update) do
    Enum.reduce([
      &name_changed/2,
      &description_changed/2,
      &zone_changed/2,
      ], [], fn (change, events) ->
      case change.(room, update) do
        nil -> events
        event -> [event | events]
      end
    end)
  end

  @doc """
  Delete an existing Room
  """
  def execute(
    %Room{uuid: room_uuid, deleted?: false},
    %DeleteRoom{room_uuid: room_uuid})
  do
    %RoomDeleted{room_uuid: room_uuid}
  end

  @doc """
  Stop the room aggregate after it has been deleted
  """
  def after_event(%RoomDeleted{}), do: :stop
  def after_event(_), do: :timer.hours(1)

  # state mutators

  def apply(%Room{} = room, %RoomCreated{} = created) do
    %Room{room |
      uuid: created.room_uuid,
      name: created.name,
      description: created.description,
      zone_uuid: created.zone_uuid
    }
  end

  def apply(%Room{} = room, %RoomDeleted{}) do
    %Room{room| deleted?: true}
  end

  def apply(%Room{} = room, %RoomNameChanged{name: name}) do
    %Room{room | name: name}
  end

  # private helpers

  defp name_changed(%Room{}, %UpdateRoom{name: ""}), do: nil
  defp name_changed(%Room{name: name}, %UpdateRoom{name: name}), do: nil
  defp name_changed(%Room{uuid: room_uuid}, %UpdateRoom{name: name}) do
    %RoomNameChanged{
      room_uuid: room_uuid,
      name: name,
    }
  end

  defp description_changed(%Room{}, %UpdateRoom{description: ""}), do: nil
  defp description_changed(%Room{description: description}, %UpdateRoom{description: description}), do: nil
  defp description_changed(%Room{uuid: room_uuid}, %UpdateRoom{description: description}) do
    %RoomDescriptionChanged{
      room_uuid: room_uuid,
      description: description,
    }
  end

  defp zone_changed(%Room{}, %UpdateRoom{room_uuid: ""}), do: nil
  defp zone_changed(%Room{zone_uuid: zone_uuid}, %UpdateRoom{zone_uuid: zone_uuid}), do: nil
  defp zone_changed(%Room{uuid: room_uuid}, %UpdateRoom{zone_uuid: zone_uuid}) do
    %RoomZoneChanged{
      room_uuid: room_uuid,
      zone_uuid: zone_uuid,
    }
  end
end
