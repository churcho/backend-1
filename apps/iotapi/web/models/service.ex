defmodule Iotapi.Service do
  use Iotapi.Web, :model

  schema "services" do
    field :name, :string
    field :client_id, :string
    field :client_secret, :string
    field :access_token, :binary
    field :url, :string
    field :oauth, :boolean, default: false
    field :bridge, :boolean, default: false
    field :enabled, :boolean, default: false
    field :type, :string
    field :search_path, :string
    field :service_state, :map

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :client_id, :client_secret, :access_token, :url, :oauth, :bridge, :enabled, :type, :search_path, :service_state])
    |> validate_required([:name])
  end
end
