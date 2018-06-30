defmodule Core.Accounts.Queries.RoleByName do
  @moduledoc false
  import Ecto.Query

  alias Core.Accounts.Projections.Role

  def new(name) do
    from r in Role,
    where: r.name == ^name
  end
end
