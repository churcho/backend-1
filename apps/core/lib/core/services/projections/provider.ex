defmodule Core.Services.Projections.Provider do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}
  schema "providers" do
    field(:name, :string)
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

    timestamps()
  end
end
