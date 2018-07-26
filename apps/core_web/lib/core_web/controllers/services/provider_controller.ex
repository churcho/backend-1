defmodule CoreWeb.ProviderController do
  @moduledoc false
  use CoreWeb, :controller

  alias Core.Services
  alias Core.DB.Provider

  def index(conn, _params) do
    providers = Services.list_providers()
    render(conn, "index.json", providers: providers)
  end

  def show(conn, %{"id" => id}) do
    provider = Services.get_provider!(id)
    render(conn, "show.json", provider: provider)
  end

  def create(conn, %{"provider" => provider_params}) do
    with {:ok, %Provider{} = provider} <-
      Services.register_provider(provider_params)
    do
      conn
      |> put_status(:created)
      |> render("show.json", provider: provider)
    end
  end

  def update(conn, %{"id" => provider_id, "provider" => provider_params}) do

    provider = Services.get_provider!(provider_id)

    with {:ok, %Provider{} = provider} <-
      Services.update_provider(provider, provider_params)
    do
      conn
      |> put_status(:ok)
      |> render("show.json", provider: provider)
    end
  end

end
