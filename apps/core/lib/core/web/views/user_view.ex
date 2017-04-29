defmodule Core.Web.UserView do
  use Core.Web, :view

  def render("index.json", %{users: users}) do
    %{
      links: %{
        self:  "/api/v1/users"
    },
      data: render_many(users, Core.Web.UserView, "user.json")
    }
  end

  def render("show.json", %{user: user}) do
  %{
    data: render_one(user, Core.Web.UserView, "user.json")
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
        email: user.email, 
      },
      role: render_one(user.role, Core.Web.RoleView, "role.json")
    }
  end
end
