defmodule Core.ServiceManager.EntityType do
  use Ecto.Schema

  schema "service_manager_entity_types" do
    field :description, :string
    field :name, :string

    has_many :entities, Core.ServiceManager.Entity
    timestamps()
  end
end
