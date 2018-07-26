defmodule Core.EntityManager.Queries.AttributeByName do
  @moduledoc false
  import Ecto.Query

  alias Core.DB.Attribute

  def new(name) do
    from e in Attribute,
    where: e.name == ^name
  end
end
