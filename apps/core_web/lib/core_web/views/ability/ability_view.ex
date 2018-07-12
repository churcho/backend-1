defmodule CoreWeb.AbilityView do
  use CoreWeb, :view

  def render("index.json", %{list: list}) do
    %{
      data: list
    }
  end
end
