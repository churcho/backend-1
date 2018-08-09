defmodule Core.DB.Event do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Core.Types.AtomType

  @primary_key {:id, :binary_id, autogenerate: false}
  @derive {Poison.Encoder, except: [:__meta__]}

  schema "events" do
    field :initialized_at, :integer
    field :occurred_at, :integer
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
      :occurred_at,
      :source,
      :topic,
      :transaction_id,
      :data
    ])
    |> generate_occurred_at()
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

  def generate_occurred_at(current_changeset) do
    IO.puts "adding occurred at...."
    case current_changeset do
      %Ecto.Changeset{valid?: true} ->
        put_change(current_changeset, :occurred_at,  DateTime.utc_now |> DateTime.to_unix)
      _ ->
        current_changeset
    end
  end
end
