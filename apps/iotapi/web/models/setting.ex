defmodule Iotapi.Setting do
  use Iotapi.Web, :model

  schema "settings" do
    field :name, :string
    field :value, :map
    field :environment, :string
    field :description, :string
    belongs_to :user, Iotapi.User

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
