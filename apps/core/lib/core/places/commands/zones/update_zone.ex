defmodule Core.Places.Commands.UpdateZone do
  @moduledoc """
  Command to update zone
  """

  defstruct [
    zone_uuid: "",
    name: "",
    description: "",
    location_uuid: "",
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Places.Commands.UpdateZone
  alias Core.Places.Projections.Zone

  validates :zone_uuid, uuid: true

  @doc """
  Assign the Zone identity
  """
  def assign_zone(%UpdateZone{} = update_zone, %Zone{uuid: zone_uuid}) do
    %UpdateZone{update_zone | zone_uuid: zone_uuid}
  end
end
