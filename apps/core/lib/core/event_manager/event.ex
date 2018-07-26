defmodule Core.EventManager.Event do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.EventManager.AtomType

  @primary_key {:id, :binary_id, autogenerate: false}
  schema "events" do
    field :initialized_at, :integer
    field :occured_at, :integer
    field :source, :string
    field :topic, AtomType
    field :transaction_id, :binary_id
    field :data, :map
    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [
      :id,
      :initialized_at,
      :occured_at,
      :source,
      :topic,
      :transaction_id,
      :data
    ])
    |> validate_required([
    ])
  end

  def generate_id(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{id: nil}} ->
        put_change(current_changeset, :id,  UUID.uuid4())
      _ ->
        current_changeset
    end
  end

  def generate_transaction_id(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{transaction_id: nil}} ->
        put_change(current_changeset, :transaction_id,  UUID.uuid4())
      _ ->
        current_changeset
    end
  end
end
