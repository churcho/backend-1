defmodule Core.EntityManager.EntityType do
  @moduledoc """
  EntityType
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Core.EntityManager.Entity
  alias Core.EntityManager.EntityType

  schema "entity_types" do
    field(:description, :string)
    field(:name, :string)
    field(:label, :string)
    has_many(:entities, Entity)
    timestamps()
  end

  def changeset(%EntityType{} = entity_type, attrs) do
    entity_type
    |> cast(attrs, [:name, :label, :description])
    |> validate_required([:name, :description])
  end
end
