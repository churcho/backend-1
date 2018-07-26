defmodule Core.Accounts.Queries.UserByUsername do
  @moduledoc false
  import Ecto.Query

  alias Core.Accounts.User

  def new(username) do
    from u in User,
    where: u.username == ^username
  end
end
