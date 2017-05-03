defmodule Core.ServiceManager.Service do
  @moduledoc """
  Service
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.ServiceManager.Service

  schema "service_manager_services" do
    field :name, :string
    field :slug, :string
    field :host, :string
    field :port, :string
    field :client_id, :string
    field :client_secret, :string
    field :access_token, :binary
    field :api_key, :string
    field :enabled, :boolean
    field :allows_import, :boolean
    field :imported_at, :utc_datetime
    field :requires_authorization, :boolean
    field :authorized, :boolean
    field :searchable, :boolean
    field :search_path, :string

    field :state, :map
    field :metadata, :map
    field :configuration, :map

    has_many :entities, Core.ServiceManager.Entity
    has_many :events, Core.EventManager.Event
    belongs_to :provider, Core.ServiceManager.Provider
    timestamps()
  end

  def changeset(%Service{} = service, attrs) do
    service
    |> cast(attrs, [:name,
                     :host,
                     :port,
                     :client_id,
                     :client_secret,
                     :access_token,
                     :api_key,
                     :enabled,
                     :authorized,
                     :searchable,
                     :search_path,
                     :state,
                     :slug,
                     :imported_at,
                     :allows_import,
                     :requires_authorization,
                     :metadata,
                     :configuration,
                     :provider_id])
    |> validate_required([:name, :provider_id])
  end
end
