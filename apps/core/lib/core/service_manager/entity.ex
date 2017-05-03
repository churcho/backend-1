defmodule Core.ServiceManager.Entity do
  @moduledoc """
  Entity Schema
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Core.ServiceManager.Entity

  schema "service_manager_entities" do
    field :name, :string
    field :display_name, :string
    field :label, :string
    field :slug, :string
    field :description, :string
    field :metadata, :map
    field :state, :map
    field :configuration, :map
    field :source, :string
    field :uuid, :string
    has_many :events, Core.EventManager.Event
    belongs_to :service, Core.ServiceManager.Service
    belongs_to :entity_type, Core.ServiceManager.EntityType
    timestamps()
  end

  def changeset(%Entity{} = entity, attrs) do
  	entity
  	|> cast(attrs, [:name,
  	                 :uuid,
  	                 :description,
  	                 :label,
  	                 :metadata,
  	                 :state,
  	                 :display_name,
  	                 :slug,
  	                 :configuration,
  	                 :source,
  	                 :service_id])
  	|> validate_required([:name, :uuid])
  end
end
