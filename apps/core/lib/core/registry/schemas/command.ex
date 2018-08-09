defmodule Core.DB.Command do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset


  schema "commands" do
    field :title, :string
    field :action, :string
    timestamps()

    embeds_many :action_arguments, ActionArgument do
      field :name, :string
      field :type,  :string
      field :required, :boolean
      field :index, :integer
    end

    embeds_many :action_events, ActionEvent do
      field :result_state, :string
      field :message, :string
    end
  end

  @doc false
  def changeset(ability, attrs) do
    ability
    |> cast(attrs, [
      :title,
      :action
      ])
    |> cast_embed(:action_arguments, with: &action_argument_changeset/2)
    |> cast_embed(:action_events, with: &action_event_changeset/2)
    |> validate_required([
      :action
      ])
  end

  defp action_argument_changeset(schema, params) do
    schema
    |> cast(params, [:name, :type, :required, :index])
  end

  defp action_event_changeset(schema, params) do
    schema
    |> cast(params, [:result_state, :message])
  end
end
