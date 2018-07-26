defmodule Core.DB.EntityCategory do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset

  schema "entities" do
    field :name, :string
    field :description, :string

    has_many :entities, Core.DB.Entity
    timestamps()
  end

  @doc false
  def changeset(entity, attrs) do
    entity
    |> cast(attrs, [
      :name,
      :description

    ])
    |> validate_required([
      :name
    ])
  end

end
