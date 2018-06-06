defmodule Core.Places.Commands.DeleteLocation do
  @moduledoc false
  defstruct [
    location_uuid: "",
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Places.Projections.Location
  alias Core.Places.Commands.DeleteLocation

  validates :location_uuid, uuid: true

  def assign_location(%DeleteLocation{} = delete, %Location{uuid: location_uuid}) do
    %DeleteLocation{delete |
      location_uuid: location_uuid,
    }
  end

end
