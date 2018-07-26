defmodule Core.EntityManager.Queries.ListEntities do
  @moduledoc false
  import Ecto.Query

  alias Core.DB.Entity

  def new do
    from e in Entity,
    order_by: e.name
  end
end
