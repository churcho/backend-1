defmodule Core.Things.Entity do
  @moduledoc """
  Entity Schema
  """
  use Ecto.Schema

  @primary_key {:uuid, :binary_id, autogenerate: false}
  schema "entities" do
    field(:name, :string)
    field(:label, :string)
    field(:slug, :string)
    field(:description, :string)
    field(:service_uuid, :binary_id)
    field(:source, :string)
    field(:entity_type_uuid, :binary_id)
    field(:abilities, {:array, :binary_id}, default: [])
    timestamps()
  end
end
