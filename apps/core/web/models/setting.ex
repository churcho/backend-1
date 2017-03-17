defmodule Core.Setting do
  use Core.Web, :model

  schema "settings" do
    field :name, :string
    field :value, :map
    field :environment, :string
    field :description, :string
    belongs_to :user, Core.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :value, :environment, :description, :user_id])
    |> validate_required([:name, :value, :environment, :description, :user_id])
  end
end
