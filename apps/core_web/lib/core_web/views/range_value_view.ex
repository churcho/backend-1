defmodule CoreWeb.RangeValueView do
  use CoreWeb, :view
  alias CoreWeb.RanageValueView

  def render("index.json", %{range_values: range_values}) do
    %{data: render_many(range_values, RanageValueView, "ranage_value.json")}
  end

  def render("show.json", %{ranage_value: ranage_value}) do
    %{data: render_one(ranage_value, RanageValueView, "ranage_value.json")}
  end

  def render("range_value.json", %{range_value: range_value}) do
    %{id: range_value.id,
      min: range_value.min,
      max: range_value.max}
  end
end
