defmodule CoreWeb.ProviderController do
  use CoreWeb, :controller

  alias Core.ProviderManager
  alias Core.ProviderManager.Provider


  def index(conn, _params) do
    providers = ProviderManager.list_providers()
    render(conn, "index.json", providers: providers)
  end

  def create(conn, %{"provider" => provider_params}) do
    with {:ok, %Provider{} = provider} <- ProviderManager.create_provider(provider_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("provider", provider_path(conn, :show, provider))
      |> render("show.json", provider: provider)
    end
  end


  def show(conn, %{"id" => id}) do
    provider = ProviderManager.get_provider!(id)
    render(conn, "show.json", provider: provider)
  end

  def update(conn, %{"id" => id, "provider" => provider_params}) do
    provider = ProviderManager.get_provider!(id)

    with {:ok, %Provider{} = provider} <- ProviderManager.update_provider(provider, provider_params) do
      render(conn, "show.json", provider: provider)
    end
  end

  def delete(conn, %{"id" => id}) do
    provider = ProviderManager.get_provider!(id)
    with {:ok, %Provider{}} <- ProviderManager.delete_provider(provider) do
      send_resp(conn, :no_content, "")
    end
  end
end
