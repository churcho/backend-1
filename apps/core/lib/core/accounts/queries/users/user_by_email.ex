defmodule Core.Accounts.Queries.UserByEmail do
  @moduledoc false
  import Ecto.Query

  alias Core.Accounts.Projections.User

  def new(email) do
    from u in User,
    where: u.email == ^email
  end
end
