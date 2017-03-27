defmodule Core.Service do
  use Core.Web, :model

  schema "services" do
    field :name, :string
    field :client_id, :string
    field :client_secret, :string
    field :access_token, :binary
    field :api_key, :string
    field :enabled, :boolean
    field :searchable, :boolean
    field :search_path, :string
    field :service_state, :map
    field :slug, :string

    has_many :entities, Core.Entity
    belongs_to :provider, Core.Provider
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name,
                     :client_id,
                     :client_secret,
                     :access_token,
                     :api_key,
                     :enabled,
                     :searchable,
                     :search_path,
                     :service_state,
                     :slug,
                     :provider_id])
    |> validate_required([:name, :provider_id])
  end
end
