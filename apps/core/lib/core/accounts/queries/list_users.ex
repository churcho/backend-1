defmodule Core.Accounts.Queries.ListUsers do
  @moduledoc """
  Query all roles
  """
  import Ecto.Query

  alias Core.DB.User

  def new do
    from u in User,
    order_by: u.id
  end
end
