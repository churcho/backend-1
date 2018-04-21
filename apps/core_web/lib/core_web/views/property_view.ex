defmodule CoreWeb.PropertyView do
  use CoreWeb, :view
  alias CoreWeb.PropertyView

  def render("index.json", %{properties: properties}) do
    %{data: render_many(properties, PropertyView, "property.json")}
  end

  def render("show.json", %{property: property}) do
    %{data: render_one(property, PropertyView, "property.json")}
  end

  def render("property.json", %{property: property}) do
    %{
      id: property.id,
      title: property.title,
      name: property.name,
      description: property.description,
      type: property.type,
      readOnly: property.readOnly,
      unit: render_one(property.unit, CoreWeb.UnitView, "unit.json"),
      range_value: render_one(property.range_value, CoreWeb.RangeValueView, "range_value.json"),
      bool_value: render_one(property.bool_value, CoreWeb.BoolValueView, "bool_value.json")
    }
  end
end
