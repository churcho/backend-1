defmodule Core.Web.RoleView do
  use Core.Web, :view

  def render("index.json", %{roles: roles}) do
    %{
      links: %{
        self:  "/api/v1/roles"
      },
      data: render_many(roles, Core.Web.RoleView, "role.json")
    }
  end

  def render("show.json", %{role: role}) do    
    %{
      data: render_one(role, Core.Web.RoleView, "role.json")
    }
  end

  def render("role.json", %{role: role}) do
    %{
      links: %{
        self:  "/api/v1/roles/#{role.id}"
      },
      type: "roles",
      id: role.id,
      attributes:
      %{
        name: role.name,
        description: role.description
      }
    }

  end
end
