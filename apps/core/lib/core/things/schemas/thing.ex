defmodule Core.DB.Thing do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset
  alias Core.DB.{
    ThingCategory,
    ThingComponent,
    Connection
  }

  schema "things" do
    field :name, :string
    field :label, :string
    field :remote_id, :string
    field :category, :string
    field :manufacturer, :string
    field :model_number, :string
    field :icon, :string
    field :virtual, :boolean
    field :state, :map
    field :settings, :map
    field :online, :boolean

    belongs_to :thing_category, ThingCategory
    many_to_many :connections, Connection, join_through: "connection_things"
    many_to_many :components, ThingComponent, join_through: "thing_components"
    timestamps()
  end

  @doc false
  def changeset(entity, attrs) do
    entity
    |> cast(attrs, [
      :name,
      :label,
      :remote_id,
      :category,
      :manufacturer,
      :model_number,
      :virtual,
      :state,
      :settings,
      :online

    ])
    |> validate_required([
      :name
    ])
  end

end
