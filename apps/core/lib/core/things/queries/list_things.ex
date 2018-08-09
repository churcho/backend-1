defmodule Core.ThingManager.Queries.ListThings do
  @moduledoc false
  import Ecto.Query

  alias Core.DB.Thing

  def new do
    from e in Thing,
    order_by: e.name
  end
end
