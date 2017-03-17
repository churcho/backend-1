defmodule Core.Provider do
  use Core.Web, :model

  schema "providers" do
    field :name, :string
    field :description, :string
    field :url, :string
    field :enabled, :boolean
    field :lorp_name, :string
    field :registered_at, :utc_datetime
    field :last_seen, :utc_datetime
    field :provides, :map
    field :configuration, :map
    field :keywords, {:array, :string}
    field :version, :string




    has_many :services, Core.Service
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name,
                     :url,
                     :description,
                     :enabled,
                     :lorp_name,
                     :registered_at,
                     :last_seen,
                     :provides,
                     :configuration,
                     :keywords,
                     :version])
    |> validate_required([:name, :url])
  end
end
