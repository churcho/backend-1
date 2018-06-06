defmodule CoreWeb.SessionView do
  use CoreWeb, :view

  def render("show.json", %{jwt: jwt, user: user}) do
    %{
      jwt: jwt,
      user:  %{
         type: "user",
         uuid: user.uuid,
         username: user.username,
         first_name: user.first_name,
         last_name: user.last_name,
         email: user.email
       }
    }
  end

  def render("error.json", _) do
    %{error: "Invalid email or password"}
  end

  def render("delete.json", _) do
    %{ok: true}
  end

  def render("forbidden.json", %{error: error}) do
    %{error: error}
  end
end
