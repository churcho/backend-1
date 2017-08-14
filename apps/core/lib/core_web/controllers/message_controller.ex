defmodule CoreWeb.MessageController do
  use CoreWeb, :controller

  alias Core.ServiceManager
  alias Core.ServiceManager.Message

  action_fallback CoreWeb.FallbackController

  def index(conn, _params) do
    messages = ServiceManager.list_messages()
    render(conn, "index.json", messages: messages)
  end

  def create(conn, %{"message" => message_params}) do
    with {:ok, %Message{} = message} <- ServiceManager.create_message(message_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", message_path(conn, :show, message))
      |> render("show.json", message: message)
    end
  end

  def show(conn, %{"id" => id}) do
    message = ServiceManager.get_message!(id)
    render(conn, "show.json", message: message)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = ServiceManager.get_message!(id)

    with {:ok, %Message{} = message} <- ServiceManager.update_message(message, message_params) do
      render(conn, "show.json", message: message)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = ServiceManager.get_message!(id)
    with {:ok, %Message{}} <- ServiceManager.delete_message(message) do
      send_resp(conn, :no_content, "")
    end
  end
end
