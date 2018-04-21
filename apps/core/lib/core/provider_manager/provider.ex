defmodule Core.ProviderManager.Provider do
  @moduledoc """
  Provider
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.ProviderManager.Provider
  alias Core.ServiceManager.Service

  schema "providers" do
    field(:name, :string)
    field(:description, :string)
    field(:searchable, :boolean)
    field(:url, :string)
    field(:enabled, :boolean)
    field(:lorp_name, :string)
    field(:auth_method, :string)
    field(:registered_at, :utc_datetime)
    field(:last_seen, :utc_datetime)
    field(:provides, {:array, :map})
    field(:max_services, :integer)
    field(:configuration, :map)
    field(:allows_import, :boolean)
    field(:version, :string)
    field(:keywords, {:array, :string})
    field(:logo_path, :string)
    field(:icon_path, :string)
    field(:slug, :string)

    has_many(:services, Service)
    timestamps()
  end

  def changeset(%Provider{} = provider, attrs) do
    provider
    |> cast(attrs, [
      :name,
      :description,
      :searchable,
      :url,
      :enabled,
      :lorp_name,
      :auth_method,
      :registered_at,
      :last_seen,
      :provides,
      :max_services,
      :configuration,
      :allows_import,
      :logo_path,
      :icon_path,
      :keywords,
      :slug,
      :version
    ])
    |> validate_required([:name, :url])
    |> unique_constraint(:name)
  end
end
