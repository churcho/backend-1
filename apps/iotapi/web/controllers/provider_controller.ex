defmodule Iotapi.ProviderController do
  use Iotapi.Web, :controller

  alias Iotapi.Provider

  def index(conn, _params) do
    providers = Repo.all(Provider)
    render(conn, "index.json", providers: providers)
  end

  def create(conn, %{"provider" => provider_params}) do
    changeset = Provider.changeset(%Provider{}, provider_params)

    case Repo.insert(changeset) do
      {:ok, provider} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", provider_path(conn, :show, provider))
        |> render("show.json", provider: provider)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Iotapi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    provider = Repo.get!(Provider, id)
    render(conn, "show.json", provider: provider)
  end

  def update(conn, %{"id" => id, "provider" => provider_params}) do
    provider = Repo.get!(Provider, id)
    changeset = Provider.changeset(provider, provider_params)

    case Repo.update(changeset) do
      {:ok, provider} ->
        render(conn, "show.json", provider: provider)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Iotapi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    provider = Repo.get!(Provider, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(provider)

    send_resp(conn, :no_content, "")
  end
end
