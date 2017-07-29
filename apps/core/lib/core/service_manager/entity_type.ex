defmodule Core.ServiceManager.EntityType do
  @moduledoc """
  EntityType
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Core.ServiceManager.Entity
  alias Core.ServiceManager.EntityType

  schema "service_manager_entity_types" do
    field :description, :string
    field :name, :string

    has_many :entities, Entity
    timestamps()
  end

  def changeset(%EntityType{} = entity_type, attrs) do
  	entity_type
  	|> cast(attrs, [:name, :description])
  	|> validate_required([:name, :description])
  end
end
