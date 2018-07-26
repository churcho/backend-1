defmodule Core.DB.Command do
  @moduledoc false
  use Core.BaseSchema
  import Ecto.Changeset


  schema "commands" do
    field :title, :string
    field :action, :string
    field :event, :string
    field :event_success_message, :string
    field :event_error_message, :string
    timestamps()

    embeds_many :action_arguments, ActionArgument do
      field :name, :string
      field :type,  :string
      field :required, :boolean
      field :index, :integer
    end


  end

  @doc false
  def changeset(ability, attrs) do
    ability
    |> cast(attrs, [
      :title,
      :action,
      :event,
      :event_success_message,
      :event_error_message
      ])
    |> cast_embed(:action_arguments, with: &action_argument_changeset/2)
    |> validate_required([
      :action,
      :event
      ])
  end

  defp action_argument_changeset(schema, params) do
    schema
    |> cast(params, [:name, :type, :required, :index])
  end
end
