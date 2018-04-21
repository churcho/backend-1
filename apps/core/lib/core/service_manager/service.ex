defmodule Core.ServiceManager.Service do
  @moduledoc """
  Service
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.ServiceManager.{
    Service,
    PropertyType,
    ActionType,
    EventType
  }
  alias Core.EntityManager.Entity
  alias Core.ProviderManager.Provider

  schema "services" do
    field(:name, :string)
    field(:description, :string)
    field(:slug, :string)
    field(:host, :string)
    field(:port, :string)
    field(:client_id, :string)
    field(:client_secret, :string)
    field(:access_token, :binary)
    field(:api_key, :string)
    field(:enabled, :boolean)
    field(:imported_at, :utc_datetime)
    field(:authorized, :boolean)

    field(:state, :map)
    field(:metadata, :map)
    field(:configuration, :map)

    has_many(
      :property_types,
      PropertyType,
      on_delete: :delete_all
    )

    has_many(
      :action_types,
      ActionType,
      on_delete: :delete_all
    )

    has_many(
      :event_types,
      EventType,
      on_delete: :delete_all
    )

    has_many(
      :service_properties,
      through: [:property_types, :property]
    )

    has_many(
      :service_actions,
      through: [:action_types, :action]
    )

    has_many(
      :service_events,
      through: [:event_types, :event]
    )

    has_many(:entities, Entity)
    belongs_to(:provider, Provider)
    timestamps()
  end

  def changeset(%Service{} = service, attrs) do
    service
    |> cast(attrs, [
      :name,
      :host,
      :port,
      :client_id,
      :client_secret,
      :access_token,
      :api_key,
      :enabled,
      :authorized,
      :state,
      :slug,
      :imported_at,
      :metadata,
      :configuration,
      :provider_id
    ])
    |> validate_required([:name, :provider_id])
  end
end
