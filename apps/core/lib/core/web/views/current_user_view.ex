defmodule Core.Web.CurrentUserView do
  use Core.Web, :view

  def render("show.json", %{user: user}) do
    %{
     type: "user",
     id: user.id,
     first_name: user.first_name,
     last_name: user.last_name,
     email: user.email,
     role: render_one(user.role, Core.Web.RoleView, "role.json")       
   }
  end

  def render("error.json", _) do
  end
end
