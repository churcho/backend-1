defmodule Core.Accounts.Queries.ListUsers do
  @moduledoc """
  Query all roles
  """
  import Ecto.Query

  alias Core.Accounts.Projections.User

  def new do
    from u in User,
    order_by: u.username
  end
end
