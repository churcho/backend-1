defmodule Core.Services.Projectors.Provider do
  @moduledoc false
  use Commanded.Projections.Ecto,
    name: "Services.Projectors.Provider",
    consistency: :strong

  alias Core.Services.Events.{
    ProviderRegistered,
  }
  alias Core.Services.Projections.Provider
  alias Ecto.Multi

  project %ProviderRegistered{} = registered do
    Multi.insert(multi, :provider, %Provider{
      uuid: registered.provider_uuid,
      name: registered.name
    })
  end

  defp provider_query(provider_uuid) do
    from(p in Provider, where: p.uuid == ^provider_uuid)
  end
end
