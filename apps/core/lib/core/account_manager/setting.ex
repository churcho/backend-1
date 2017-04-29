defmodule Core.AccountManager.Setting do
  @moduledoc """
  Setting
  """
  use Core.Web, :model

  schema "settings" do
    field :name, :string
    field :value, :map
    field :environment, :string
    field :description, :string
    belongs_to :user, Core.AccountManager.User

    timestamps()
  end


end
