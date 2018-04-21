defmodule CoreWeb.BoolValueView do
  use CoreWeb, :view
  alias CoreWeb.BoolValueView

  def render("index.json", %{bool_values: bool_values}) do
    %{data: render_many(bool_values, BoolValueView, "bool_value.json")}
  end

  def render("show.json", %{bool_value: bool_value}) do
    %{data: render_one(bool_value, BoolValueView, "bool_value.json")}
  end

  def render("bool_value.json", %{bool_value: bool_value}) do
    %{id: bool_value.id,
      values: bool_value.values}
  end
end
