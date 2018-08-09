defmodule Core.ThingManager.Queries.ThingByRemoteId do
  @moduledoc false
  import Ecto.Query

  alias Core.DB.Thing

  def new(remote_id) do
    from e in Thing,
    where: e.remote_id == ^remote_id
  end
end
