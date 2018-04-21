defmodule CoreWeb.PropertyTypeView do
  use CoreWeb, :view
  alias CoreWeb.PropertyTypeView

  def render("index.json", %{property_types: property_types}) do
    %{data: render_many(property_types, PropertyTypeView, "property_type.json")}
  end

  def render("show.json", %{property_type: property_type}) do
    %{data: render_one(property_type, PropertyTypeView, "property_type.json")}
  end

  def render("property_type.json", %{property_type: property_type}) do
    %{
      id: property_type.id,
      label: property_type.label,
      name: property_type.name,
      enabled: property_type.enabled,
      property_id: property_type.property_id,
      entity_id: property_type.entity_id
    }
  end
end
