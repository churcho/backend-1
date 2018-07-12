defmodule Core.Services.Projections.Entity do
  @moduledoc false
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}
  schema "entities" do
    field :name, :string
    field :label, :string
    field :connection_uuid, :binary_id
    field :remote_id, :string
    field :components, {:array, :map}
    timestamps()
  end
end
