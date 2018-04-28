defmodule Core.PropertyManager.BooleanProperty do
  @moduledoc """
  Property Schema
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.PropertyManager.BooleanProperty
  alias Core.PropertyManager.BoolValue

  schema "boolean_properties" do
    field(:description, :string)
    field(:title, :string)
    field(:name, :string)
    field(:type, :string)
    field(:readOnly, :boolean)
    embeds_one :value, BoolValue, on_replace: :update

    timestamps()
  end

  @doc false
  def changeset(%BooleanProperty{} = property, attrs) do
    property
    |> cast(attrs, [
      :name,
      :description,
      :type,
      :readOnly,
      :title
      ])

    |> cast_embed(:value, with: &bool_value_changeset/2)
    |> unique_constraint(:name)
    |> validate_required([:name, :description, :type])
  end

  defp bool_value_changeset(%BoolValue{} = bool_value, attrs) do
    bool_value
    |> cast(attrs, [:enum_type])
  end
end
