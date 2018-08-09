defmodule Core.Accounts.Queries.ListRoles do
  @moduledoc """
  Query all roles
  """
  import Ecto.Query

  alias Core.DB.Role

  def new do
    from r in Role,
    order_by: r.name
  end
end
