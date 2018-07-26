defmodule Core.EntityManager.Queries.EntityByRemoteId do
  @moduledoc false
  import Ecto.Query

  alias Core.DB.Entity

  def new(remote_id) do
    from e in Entity,
    where: e.remote_id == ^remote_id
  end
end
