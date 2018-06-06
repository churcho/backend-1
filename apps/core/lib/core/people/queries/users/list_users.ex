defmodule Core.People.Queries.ListUsers do
  @moduledoc """
  Query all roles
  """
  import Ecto.Query

  alias Core.People.Projections.User

  def new do
    from u in User,
    order_by: u.username
  end
end
