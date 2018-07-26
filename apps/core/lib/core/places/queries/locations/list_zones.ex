defmodule Core.Places.Queries.ListZones do
  @moduledoc false
  import Ecto.Query

  alias Core.Places.Zone

  def new do
    from z in Zone,
    order_by: z.name
  end
end
