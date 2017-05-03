defmodule Core.AccountManager.Setting do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.AccountManager.Setting

  schema "settings" do
    field :name, :string
    field :value, :map
    field :environment, :string
    field :description, :string
    belongs_to :user, Core.AccountManager.User

    timestamps()
  end

  def changeset(%Setting{} = setting, attrs) do
    setting
    |> cast(attrs, [:name, :value, :environment, :description, :user_id])
    |> validate_required([:name, :value, :environment, :description, :user_id])
  end
end
