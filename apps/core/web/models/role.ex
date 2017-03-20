defmodule Core.Role do
  use Core.Web, :model

  schema "roles" do
    field :name, :string
    field :description, :string

    has_many :users, Core.User
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
