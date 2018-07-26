defmodule CoreWeb.CurrentUserView do
  use CoreWeb, :view

  def render("show.json", %{user: user}) do
    %{
     type: "user",
     id: user.id,
     email: user.email
   }
  end

  def render("error.json", _) do
  end
end
