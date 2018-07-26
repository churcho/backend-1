defmodule Core.Places.Queries.ListLocations do
  @moduledoc false
  import Ecto.Query

  alias Core.Places.Location

  def new do
    from l in Location,
    order_by: l.name
  end
end
