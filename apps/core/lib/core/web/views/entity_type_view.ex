defmodule Core.Web.EntityTypeView do
  use Core.Web, :view
  alias Core.Web.EntityTypeView

  def render("index.json", %{entity_types: entity_types}) do
    %{data: render_many(entity_types, EntityTypeView, "entity_type.json")}
  end

  def render("show.json", %{entity_type: entity_type}) do
    %{data: render_one(entity_type, EntityTypeView, "entity_type.json")}
  end

  def render("entity_type.json", %{entity_type: entity_type}) do
    %{id: entity_type.id,
      name: entity_type.name,
      description: entity_type.description}
  end
end
