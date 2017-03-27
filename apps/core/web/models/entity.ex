defmodule Core.Entity do
  use Core.Web, :model

  schema "entities" do
    field :name, :string
    field :uuid, :string
    field :description, :string
    field :label, :string
    field :metadata, :map
    field :state, :map
    field :display_name, :string
    field :configuration, :map
    field :source, :string

    belongs_to :service, Core.Service

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, 
                     :uuid, 
                     :description, 
                     :label, 
                     :metadata, 
                     :state, 
                     :display_name, 
                     :configuration, 
                     :source,
                     :service_id])
    |> validate_required([:name, :uuid])
  end
end
