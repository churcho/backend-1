defmodule Core.Places.Commands.DeleteZone do
  @moduledoc false
  defstruct [
    zone_uuid: "",
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Places.Projections.Zone
  alias Core.Places.Commands.DeleteZone

  validates :zone_uuid, uuid: true

  def assign_zone(%DeleteZone{} = delete, %Zone{uuid: zone_uuid}) do
    %DeleteZone{delete |
      zone_uuid: zone_uuid,
    }
  end

end
