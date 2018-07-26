defmodule Core.EntityManager.Queries.CommandByName do
  @moduledoc false
  import Ecto.Query

  alias Core.DB.Command

  def new(name) do
    from e in Command,
    where: e.name == ^name
  end
end
