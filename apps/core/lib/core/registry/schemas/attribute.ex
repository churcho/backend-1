defmodule Core.DB.Attribute do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset


  schema "attributes" do
    field :name, :string
    field :description, :string
    field :type, :string
    field :enum, {:array, :string}
    field :units, {:array, :string}
    field :min, :integer
    field :max, :integer
    field :read_only, :boolean

    many_to_many :components, Core.DB.Component, join_through: "component_attributes"
    timestamps()
  end

  @doc false
  def changeset(services, attrs) do
    services
    |> cast(attrs, [
      :name,
      :description,
      :type,
      :enum,
      :units,
      :min,
      :max,
      :read_only
      ])
    |> validate_required([:name])
  end
end
