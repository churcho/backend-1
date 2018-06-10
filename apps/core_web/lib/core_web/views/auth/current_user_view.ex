defmodule CoreWeb.CurrentUserView do
  use CoreWeb, :view

  def render("show.json", %{user: user}) do
    %{
     type: "user",
     uuid: user.uuid,
     email: user.email
   }
  end

  def render("error.json", _) do
  end
end
