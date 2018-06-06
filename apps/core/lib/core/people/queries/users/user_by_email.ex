defmodule Core.People.Queries.UserByEmail do
  @moduledoc false
  import Ecto.Query

  alias Core.People.Projections.User

  def new(email) do
    from u in User,
    where: u.email == ^email
  end
end
