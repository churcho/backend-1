defmodule Core.EntityManager.Entity do
  @moduledoc """
  Entity Schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Core.EntityManager.{
    Entity,
    PropertyType,
    ActionType,
    EntityType,
    EventType
  }

  alias Core.ServiceManager.Service

  schema "entities" do
    field(:name, :string)
    field(:display_name, :string)
    field(:label, :string)
    field(:slug, :string)
    field(:description, :string)
    field(:source, :string)
    field(:uuid, :string)
    field(:metadata, :map)
    field(:state, :map)
    field(:configuration, :map)

    has_many(
      :property_types,
      PropertyType,
      on_delete: :delete_all
    )

    has_many(
      :action_types,
      ActionType,
      on_delete: :delete_all
    )

    has_many(
      :event_types,
      EventType,
      on_delete: :delete_all
    )

    has_many(
      :entity_properties,
      through: [:property_types, :property]
    )

    has_many(
      :entity_actions,
      through: [:action_types, :action]
    )

    has_many(
      :entity_events,
      through: [:event_types, :event]
    )

    belongs_to(:service, Service)
    belongs_to(:entity_type, EntityType)
    timestamps()
  end

  def changeset(%Entity{} = entity, attrs) do
    entity
    |> cast(attrs, [
      :name,
      :uuid,
      :description,
      :label,
      :metadata,
      :state,
      :display_name,
      :slug,
      :configuration,
      :source,
      :entity_type_id,
      :service_id
    ])
    |> validate_required([:name, :uuid])
  end
end
