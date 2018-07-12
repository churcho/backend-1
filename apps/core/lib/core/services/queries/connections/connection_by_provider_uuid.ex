defmodule Core.Services.Queries.ConnectionByProviderUuid do
  @moduledoc false
  import Ecto.Query

  alias Core.Services.Projections.Connection

  def new(provider_uuid) do
    from p in Connection,
    where: p.provider_uuid == ^provider_uuid
  end
end
