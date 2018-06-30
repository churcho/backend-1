defmodule Core.Places.Aggregates.Zone do
  @moduledoc false
  defstruct [
    uuid: nil,
    name: nil,
    description: nil,
    location_uuid: nil,
    deleted?: false,
  ]

  alias Core.Places.Aggregates.Zone
  alias Core.Places.Commands.{
    CreateZone,
    UpdateZone,
    DeleteZone
  }

  alias Core.Places.Events.{
    ZoneCreated,
    ZoneDeleted,
    ZoneNameChanged,
    ZoneDescriptionChanged,
    ZoneLocationChanged
  }

  @doc """
  Create a new Zone
  """
  def execute(%Zone{uuid: nil}, %CreateZone{} = create) do
    %ZoneCreated{
      zone_uuid: create.zone_uuid,
      name: create.name,
      description: create.description,
      location_uuid: create.location_uuid
    }
  end

  @doc """
  Update a zone's name, description
  """
  def execute(%Zone{} = zone, %UpdateZone{} = update) do
    Enum.reduce([
      &name_changed/2,
      &description_changed/2,
      &location_changed/2,
      ], [], fn (change, events) ->
      case change.(zone, update) do
        nil -> events
        event -> [event | events]
      end
    end)
  end

  @doc """
  Delete an existing Zone
  """
  def execute(
    %Zone{uuid: zone_uuid, deleted?: false},
    %DeleteZone{zone_uuid: zone_uuid})
  do
    %ZoneDeleted{zone_uuid: zone_uuid}
  end

  @doc """
  Stop the zone aggregate after it has been deleted
  """
  def after_event(%ZoneDeleted{}), do: :stop
  def after_event(_), do: :timer.hours(1)

  # state mutators

  def apply(%Zone{} = zone, %ZoneCreated{} = created) do
    %Zone{zone |
      uuid: created.zone_uuid,
      name: created.name
    }
  end

  def apply(%Zone{} = zone, %ZoneDeleted{}) do
    %Zone{zone| deleted?: true}
  end

  def apply(%Zone{} = zone, %ZoneNameChanged{name: name}) do
    %Zone{zone | name: name}
  end

  def apply(%Zone{} = zone, %ZoneDescriptionChanged{description: description}) do
    %Zone{zone | description: description}
  end

  def apply(%Zone{} = zone, %ZoneLocationChanged{location_uuid: location_uuid}) do
    %Zone{zone | location_uuid: location_uuid}
  end

  # private helpers

  defp name_changed(%Zone{}, %UpdateZone{name: ""}), do: nil
  defp name_changed(%Zone{name: name}, %UpdateZone{name: name}), do: nil
  defp name_changed(%Zone{uuid: zone_uuid}, %UpdateZone{name: name}) do
    %ZoneNameChanged{
      zone_uuid: zone_uuid,
      name: name,
    }
  end

  defp description_changed(%Zone{}, %UpdateZone{description: ""}), do: nil
  defp description_changed(%Zone{description: description}, %UpdateZone{description: description}), do: nil
  defp description_changed(%Zone{uuid: zone_uuid}, %UpdateZone{description: description}) do
    %ZoneDescriptionChanged{
      zone_uuid: zone_uuid,
      description: description,
    }
  end

  defp location_changed(%Zone{}, %UpdateZone{location_uuid: ""}), do: nil
  defp location_changed(%Zone{location_uuid: location_uuid}, %UpdateZone{location_uuid: location_uuid}), do: nil
  defp location_changed(%Zone{uuid: zone_uuid}, %UpdateZone{location_uuid: location_uuid}) do
    %ZoneLocationChanged{
      zone_uuid: zone_uuid,
      location_uuid: location_uuid,
    }
  end
end
