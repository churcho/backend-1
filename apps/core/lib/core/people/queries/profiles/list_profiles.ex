defmodule Core.People.Queries.ListProfiles do
  @moduledoc false
  import Ecto.Query

  alias Core.People.Projections.Profile

  def new do
    from p in Profile,
    order_by: p.username
  end
end
