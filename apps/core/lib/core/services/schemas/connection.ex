defmodule Core.DB.Connection do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset

  alias Core.DB.{
    Provider,
    Thing
  }
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
    field(:authorized, :boolean)

    many_to_many :things, Thing, join_through: "connection_things"
    belongs_to(:provider, Provider)
    timestamps()
  end

  @doc false
  def changeset(connection, attrs) do
    connection
    |> cast(attrs, [
      :name,
      :description,
      :provider_id,
      :slug,
      :host,
      :port,
      :client_id,
      :client_secret,
      :access_token,
      :api_key,
      :enabled,
      :authorized
    ])
    |> validate_required([
      :name
    ])
  end

end
