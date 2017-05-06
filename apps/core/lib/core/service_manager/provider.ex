defmodule Core.ServiceManager.Provider do
  @moduledoc """
  Provider
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.ServiceManager.Provider

  schema "service_manager_providers" do
    field :name, :string
    field :description, :string
    field :url, :string
    field :enabled, :boolean
    field :lorp_name, :string
    field :auth_method, :string
    field :registered_at, :utc_datetime
    field :last_seen, :utc_datetime
    field :provides, :map
    field :max_services, :integer
    field :configuration, :map
    field :version, :string
    field :keywords, {:array, :string}
    field :logo_path, :string
    field :icon_path, :string
    field :slug, :string

    has_many :services, Core.ServiceManager.Service
    timestamps()
  end

  def changeset(%Provider{} = provider, attrs) do
    provider
    |> cast(attrs, [:name,
                     :description,
                     :url,
                     :enabled,
                     :lorp_name,
                     :auth_method,
                     :registered_at,
                     :last_seen,
                     :provides,
                     :max_services,
                     :configuration,
                     :logo_path,
                     :icon_path,
                     :keywords,
                     :slug,
                     :version])
    |> validate_required([:name, :url])
    |> unique_constraint(:name)
  end
end
