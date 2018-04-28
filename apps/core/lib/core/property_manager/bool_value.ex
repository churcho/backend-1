defmodule Core.PropertyManager.BoolValue do
  @moduledoc """
  Schema for Boolean Values
  """
  use Ecto.Schema

  # embedded_schema is short for:
  #
  #   @primary_key {:id, :binary_id, autogenerate: true}
  #   schema "embedded Item" do
  #

  @primary_key false
  embedded_schema do
    field :enum_type, {:array, :boolean}
  end
end
