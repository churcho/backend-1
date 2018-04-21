defmodule CoreWeb.EntityTypeView do
  use CoreWeb, :view
  alias CoreWeb.EntityTypeView

  def render("index.json", %{entity_types: entity_types}) do
    %{
      links: [
        %{
          rel: "self",
          href: "/api/v1/entity_types",
          type: "GET"
        }
      ],
      entity_types: render_many(entity_types, EntityTypeView, "entity_type.json")
    }
  end

  def render("show.json", %{entity_type: entity_type}) do
    %{entity_type: render_one(entity_type, EntityTypeView, "entity_type.json")}
  end

  def render("entity_type.json", %{entity_type: entity_type}) do
    %{
      links: [
        %{
          rel: "self",
          href: "/api/v1/entity_types/#{entity_type.id}",
          type: "GET"
        }
      ],
      id: entity_type.id,
      name: entity_type.name,
      label: entity_type.label,
      description: entity_type.description
    }
  end
end
