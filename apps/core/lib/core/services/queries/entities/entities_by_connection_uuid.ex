defmodule Core.Services.Queries.EntityByConnectionUuid do
  @moduledoc false
  import Ecto.Query

  alias Core.Services.Projections.Entity

  def new(connection_uuid) do
    from e in Entity,
    where: e.connection_uuid == ^connection_uuid
  end
end
