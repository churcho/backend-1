defmodule Core.Places.Aggregates.Room do
  @moduledoc false
  defstruct [
    :uuid,
    :name,
    :description
  ]

  alias Core.Places.Aggregates.Room
  alias Core.Places.Commands.{
    CreateRoom,
    UpdateRoom,
    DeleteRoom
  }

  alias Core.Places.Events.{
    RoomCreated,
    RoomUpdated,
    RoomDeleted
  }

end
