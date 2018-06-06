defmodule Core.People.Queries.RoleByName do
  @moduledoc false
  import Ecto.Query

  alias Core.People.Projections.Role

  def new(name) do
    from r in Role,
    where: r.name == ^name
  end
end
