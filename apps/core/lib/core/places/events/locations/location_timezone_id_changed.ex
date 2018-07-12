defmodule Core.Places.Events.LocationTimezoneIdChanged do
  @moduledoc false
  @derive [Poison.Encoder]
  defstruct [
    :location_uuid,
    :timezone_id
  ]
end
