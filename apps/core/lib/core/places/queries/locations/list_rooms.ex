defmodule Core.Places.Queries.ListRooms do
  @moduledoc false
  import Ecto.Query

  alias Core.DB.Room

  def new do
    from r in Room,
    order_by: r.name
  end
end
