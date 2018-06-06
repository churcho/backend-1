defmodule Core.Services.Projections.Connection do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}

  schema "connections" do
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

    timestamps()
  end

end
