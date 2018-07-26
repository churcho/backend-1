defmodule Core.DB.Provider do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset
  alias Core.DB.Connection

  schema "providers" do
    field(:name, :string, unique: true)
    field(:description, :string)
    field(:url, :string)
    field(:enabled, :boolean)
    field(:auth_method, :string)
    field(:max_services, :integer)
    field(:service_name, :string, unique: true)
    field(:allows_import, :boolean)
    field(:version, :string)
    field(:required_fields, {:array, :map})
    field(:commands, {:array, :map})
    field(:keywords, {:array, :string})
    field(:logo_path, :string)
    field(:icon_path, :string)
    field(:slug, :string)

    has_many(:connections, Connection)
    timestamps()
  end

  @doc false
  def changeset(provider, attrs) do
    provider
    |> cast(attrs, [
      :name,
      :description,
      :url,
      :enabled,
      :auth_method,
      :max_services,
      :service_name,
      :allows_import,
      :version,
      :required_fields,
      :commands,
      :keywords,
      :logo_path,
      :icon_path,
      :slug
    ])
    |> validate_required([:name])
    |> unique_constraint(:service_name)
  end
end
