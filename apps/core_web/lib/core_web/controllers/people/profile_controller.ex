defmodule CoreWeb.ProfileController do
  use CoreWeb, :controller
  alias Core.People

  def index(conn, _params) do
    profiles = People.list_profiles()
    render(conn, "index.json", profiles: profiles)
  end

  def create(conn, %{"profile" => profile_params}) do
    with {:ok, %profile{} = profile} <- People.create_profile(profile_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("profile", profile_path(conn, :show, profile))
      |> render("show.json", profile: profile)
    end
  end

  def show(conn, %{"id" => id}) do
    profile = People.get_profile!(id)
    render(conn, "show.json", profile: profile)
  end
end
