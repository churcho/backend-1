defmodule Core.Provider do
  use Core.Web, :model

  schema "providers" do
    field :name, :string
    field :description, :string
    field :url, :string
    field :enabled, :boolean
    field :lorp_name, :string
    field :auth_method, :string
    field :registered_at, :utc_datetime
    field :last_seen, :utc_datetime
    field :provides, :map
    field :max_services, :integer
    field :configuration, :map
    field :version, :string
    field :keywords, {:array, :string}
    field :logo_path, :string
    field :icon_path, :string
    field :slug, :string

    has_many :services, Core.Service
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name,
                     :description,
                     :url,
                     :enabled,
                     :lorp_name,
                     :auth_method,
                     :registered_at,
                     :last_seen,
                     :provides,
                     :max_services,
                     :configuration,
                     :logo_path,
                     :icon_path,
                     :keywords,
                     :slug,
                     :version])
    |> validate_required([:name, :url])
  end
end
