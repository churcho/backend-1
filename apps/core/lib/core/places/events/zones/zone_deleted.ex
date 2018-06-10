defmodule Core.Places.Events.ZoneDeleted do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :zone_uuid
  ]
end
