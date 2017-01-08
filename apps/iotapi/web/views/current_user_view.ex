defmodule Iotapi.CurrentUserView do
  use Iotapi.Web, :view

  def render("show.json", %{user: user}) do
    user
  end

  def render("error.json", _) do
  end
end
