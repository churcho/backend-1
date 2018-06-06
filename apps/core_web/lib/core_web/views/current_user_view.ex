defmodule CoreWeb.CurrentUserView do
  use CoreWeb, :view

  def render("show.json", %{user: user}) do
    %{
     type: "user",
     uuid: user.uuid,
     first_name: user.first_name,
     last_name: user.last_name,
     email: user.email
   }
  end

  def render("error.json", _) do
  end
end
