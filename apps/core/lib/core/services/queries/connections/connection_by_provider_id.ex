defmodule Core.Services.Queries.ConnectionByProviderId do
  @moduledoc false
  import Ecto.Query

  alias Core.DB.Connection

  def new(provider_id) do
    from p in Connection,
    where: p.provider_id == ^provider_id
  end
end
