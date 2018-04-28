defmodule Core.PropertyManager.Unit do
  @moduledoc """
  Schema for Boolean Values
  """
  use Ecto.Schema

  # embedded_schema is short for:
  #
  #   @primary_key {:id, :binary_id, autogenerate: true}
  #   schema "embedded Item" do
  #
  embedded_schema do
    field :name, :string
    field :symbols, {:array, :string}
    field :description, :string
  end
end
