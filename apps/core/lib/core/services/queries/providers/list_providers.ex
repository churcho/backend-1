defmodule Core.Services.Queries.ListProviders do
  @moduledoc false
  import Ecto.Query

  alias Core.Services.Projections.Provider

  def new do
    from p in Provider,
    order_by: p.name
  end
end
