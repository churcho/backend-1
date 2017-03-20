defmodule Core.Room do
  use Core.Web, :model

  schema "rooms" do
    field :name, :string
    field :description, :string
    belongs_to :zone, Core.Zone
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name, :description])
  end
end
