defmodule Core.Services.Queries.ProviderByServiceName do
  @moduledoc false
  import Ecto.Query

  alias Core.Services.Projections.Provider

  def new(service_name) do
    from p in Provider,
    where: p.service_name == ^service_name
  end
end
