defmodule CoreWeb.SettingController do
  use CoreWeb, :controller

  alias Core.AccountManager

  def index(conn, _params) do
    settings = Core.AccountManager.list_settings()
    render(conn, "index.json", settings: settings)
  end

  def create(conn, %{"setting" => setting_params}) do
    with {:ok, %setting{} = setting} <- AccountManager.create_setting(setting_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("setting", setting_path(conn, :show, setting))
      |> render("show.json", setting: setting)
    end
  end

  def show(conn, %{"id" => id}) do
    setting = AccountManager.get_setting!(id)
    render(conn, "show.json", setting: setting)
  end

  def update(conn, %{"id" => id, "setting" => setting_params}) do
    setting = AccountManager.get_setting!(id)

    with {:ok, %setting{} = setting} <- AccountManager.update_setting(setting, setting_params) do
      render(conn, "show.json", setting: setting)
    end
  end

  def delete(conn, %{"id" => id}) do
    setting = AccountManager.get_setting!(id)
    with {:ok, %setting{}} <- AccountManager.delete_setting(setting) do
      send_resp(conn, :no_content, "#{setting} deleted")
    end
  end
end
