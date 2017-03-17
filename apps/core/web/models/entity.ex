defmodule Core.Entity do
  use Core.Web, :model

  schema "entities" do
    field :name, :string
    field :uuid, :string
    field :description, :string
    field :label, :string
    field :metadata, :map
    field :state, :map

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :uuid, :description, :label, :metadata, :state])
    |> validate_required([:name, :uuid, :description, :label, :metadata, :state])
  end
end
