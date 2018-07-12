defmodule Core.Services.Queries.ListConnections do
  @moduledoc false
  import Ecto.Query

  alias Core.Services.Projections.Connection

  def new do
    from c in Connection,
    order_by: c.name
  end
end
