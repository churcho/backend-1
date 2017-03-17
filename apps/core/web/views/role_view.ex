defmodule Core.RoleView do
  use Core.Web, :view

  def render("index.json", %{roles: roles}) do
    %{data: render_many(roles, Core.RoleView, "role.json")}
  end

  def render("show.json", %{role: role}) do
    %{data: render_one(role, Core.RoleView, "role.json")}
  end

  def render("role.json", %{role: role}) do
    %{id: role.id,
      name: role.name,
      description: role.description}
  end
end
