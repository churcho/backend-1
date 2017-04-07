defmodule Core.Web.EntityView do
  use Core.Web, :view

  def render("index.json", %{entities: entities}) do
    %{
      links: %{ self: "/api/v1/entities"},
      data: render_many(entities, Core.Web.EntityView, "entity.json")}
  end

  def render("show.json", %{entity: entity}) do
    %{data: render_one(entity, Core.Web.EntityView, "entity.json")}
  end

  def render("show_event.json", %{event: event}) do
    %{data: render_one(event, Core.Web.EventView, "event.json")}
  end

  def render("entity_events.json", %{events: events}) do
    %{data: render_many(events, Core.Web.EventView, "event.json")}
  end

  def render("entity.json", %{entity: entity}) do
    %{
     links: %{
       self: "/api/v1/entities/#{entity.id}"
     },
      id: entity.id,
      attributes: %{
        name: entity.name,
        uuid: entity.uuid,
        service_id: entity.service_id,
        service_name: entity.service.name,
        description: entity.description,
        configuration: entity.configuration,
        label: entity.label,
        metadata: entity.metadata,
        state: entity.state}
      } 
  end
end
