defmodule CoreWeb.UserView do
  use CoreWeb, :view

  def render("index.json", %{users: users}) do
    %{
      links: %{
        self:  "/api/v1/users"
    },
      data: render_many(users, CoreWeb.UserView, "user.json")
    }
  end

  def render("show.json", %{user: user}) do
  %{
    data: render_one(user, CoreWeb.UserView, "user.json")
  }
  end

  def render("user.json", %{user: user}) do
    %{
      links: %{
        self: "/api/v1/users/#{user.uuid}"
      },
      id: user.uuid,
      first_name: user.first_name,
      last_name: user.last_name,
      username: user.username,
      email: user.email,
      role: user.role_uuid
    }
  end
end
