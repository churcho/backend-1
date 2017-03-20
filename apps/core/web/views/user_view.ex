defmodule Core.UserView do
  use Core.Web, :view

  def render("index.json", %{users: users}) do
    %{
      links: %{
        self:  "/api/v1/users"
    },
      data: render_many(users, Core.UserView, "user.json")
    }
  end

  def render("show.json", %{user: user}) do
  %{
    data: render_one(user, Core.UserView, "user.json")
  }
  end

  def render("user.json", %{user: user}) do
    %{
      links: %{
        self: "/api/v1/users/#{user.id}"
      },
      id: user.id,
      attributes: %{
        first_name: user.first_name,
        last_name: user.last_name,
        username: user.username, 
      },
      role: render_one(user.role, Core.RoleView, "role.json")
    }
  end
end
