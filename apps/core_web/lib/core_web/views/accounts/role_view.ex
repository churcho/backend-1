defmodule CoreWeb.RoleView do
  use CoreWeb, :view

  def render("index.json", %{roles: roles}) do
    %{
      links: %{
        self:  "/api/v1/accounts/roles"
      },
      data: render_many(roles, CoreWeb.RoleView, "role.json")
    }
  end

  def render("show.json", %{role: role}) do
    %{data: render_one(role, CoreWeb.RoleView, "role.json")}
  end

  def render("role.json", %{role: role}) do
    %{
      links: %{
        self:  "/api/v1/accounts/roles/#{role.uuid}"
      },
      type: "roles",
      uuid: role.uuid,
      name: role.name,
      description: role.description
    }

  end
end
