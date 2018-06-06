defmodule Core.People.Queries.UserByUsername do
  @moduledoc false
  import Ecto.Query

  alias Core.People.Projections.User

  def new(username) do
    from u in User,
    where: u.username == ^username
  end
end
