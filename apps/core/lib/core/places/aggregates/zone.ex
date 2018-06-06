defmodule Core.Places.Aggregates.Zone do
  @moduledoc false
  defstruct [
    :uuid,
    :name,
    :description
  ]

  alias Core.Places.Aggregates.Zone
  alias Core.Places.Commands.{
    CreateZone,
    UpdateZone,
    DeleteRoom
  }

  alias Core.Places.Events.{
    ZoneCreated,
    ZoneUpdated,
    ZoneDeleted
  }

end
