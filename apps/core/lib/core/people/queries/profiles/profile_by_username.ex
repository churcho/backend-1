defmodule Core.People.Queries.ProfileByUsername do
  @moduledoc false
  import Ecto.Query

  alias Core.People.Profile

  def new(username) do
    from u in Profile,
    where: u.username == ^username
  end
end
