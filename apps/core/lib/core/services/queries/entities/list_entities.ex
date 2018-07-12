defmodule Core.Services.Queries.ListEntities do
  @moduledoc false
  import Ecto.Query

  alias Core.Services.Projections.Entity

  def new do
    from e in Entity,
    order_by: e.name
  end
end
