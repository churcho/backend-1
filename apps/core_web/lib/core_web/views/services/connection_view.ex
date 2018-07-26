defmodule CoreWeb.ConnectionView do
  use CoreWeb, :view

  def render("index.json", %{connections: connections}) do
    %{
      links: %{self: "/api/v1/services/connections"},
      data: render_many(connections, CoreWeb.ConnectionView, "connection.json")
    }
  end

  def render("show.json", %{connection: connection}) do
    %{
      data: render_one(connection, CoreWeb.ConnectionView, "connection.json")
    }
  end

  def render("connection.json", %{connection: connection}) do
    %{
      links: %{
        self: "/api/v1/services/connections/#{connection.id}"
      },
      id: connection.id,
      name: connection.name,
      description: connection.description,
      provider_id: connection.provider_id,
      api_key: connection.api_key
    }
end
end
