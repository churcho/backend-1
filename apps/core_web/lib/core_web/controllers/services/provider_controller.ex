defmodule CoreWeb.ProviderController do
  @moduledoc false
  use CoreWeb, :controller

  alias Core.Services
  alias Core.Services.Projections.Provider

  def index(conn, _params) do
    providers = Services.list_providers()
    render(conn, "index.json", providers: providers)
  end

  def show(conn, %{"id" => uuid}) do
    provider = Services.provider_by_uuid(uuid)
    render(conn, "show.json", provider: provider)
  end

  def create(conn, %{"provider" => provider_params}) do
    with {:ok, %Provider{} = provider} <-
      Services.create_provider(provider_params)
    do
      conn
      |> put_status(:created)
      |> render("show.json", provider: provider)
    end
  end

  def update(conn, %{"id" => provider_uuid, "provider" => provider_params}) do

    provider = Services.provider_by_uuid(provider_uuid)

    with {:ok, %Provider{} = provider} <-
      Services.update_provider(provider, provider_params)
    do
      conn
      |> put_status(:ok)
      |> render("show.json", provider: provider)
    end
  end

end
