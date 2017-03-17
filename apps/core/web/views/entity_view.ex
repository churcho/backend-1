defmodule Core.EntityView do
  use Core.Web, :view

  def render("index.json", %{entities: entities}) do
    %{data: render_many(entities, Core.EntityView, "entity.json")}
  end

  def render("show.json", %{entity: entity}) do
    %{data: render_one(entity, Core.EntityView, "entity.json")}
  end

  def render("entity.json", %{entity: entity}) do
    %{id: entity.id,
      name: entity.name,
      uuid: entity.uuid,
      description: entity.description,
      label: entity.label,
      metadata: entity.metadata,
      state: entity.state}
  end
end
