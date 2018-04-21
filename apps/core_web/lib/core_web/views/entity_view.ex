defmodule CoreWeb.EntityView do
  use CoreWeb, :view

  alias CoreWeb.EntityTypeView
  alias CoreWeb.ServiceView

  def render("index.json", %{entities: entities}) do
    %{
      links: [
        %{
          rel: "self",
          href: "/api/v1/entities"
        }
      ],
      entities: render_many(entities, CoreWeb.EntityView, "entity.json")
    }
  end

  def render("properties_index.json", %{entity: entity}) do
    %{
      links: [
        %{
          rel: "self",
          href: "/api/v1/entities/#{entity.id}/properties",
          type: "GET"
        }
      ],
      properties:
        render_many(
          entity.property_types,
          __MODULE__,
          "property.json",
          as: :property
        )
    }
  end

  def render("actions_index.json", %{entity: entity}) do
    %{
      links: [
        %{
          rel: "self",
          href: "/api/v1/entities/#{entity.id}/actions",
          type: "GET"
        }
      ],
      actions:
        render_many(
          entity.action_types,
          __MODULE__,
          "action.json",
          as: :action
        )
    }
  end

  def render("events_index.json", %{entity: entity}) do
    %{
      links: [
        %{
          rel: "self",
          href: "/api/v1/entities/#{entity.id}/events",
          type: "GET"
        }
      ],
      actions:
        render_many(
          entity.event_types,
          __MODULE__,
          "event.json",
          as: :event
        )
    }
  end

  def render("show_entity_property.json", %{property: property}) do
    property["value"]
  end

  def render("show.json", %{entity: entity}) do
    %{
      entity: render_one(entity, CoreWeb.EntityView, "entity.json")
    }
  end

  def render("show_event.json", %{event: event}) do
    %{data: render_one(event, CoreWeb.EventView, "event.json")}
  end

  def render("entity_events.json", %{events: events}) do
    %{data: render_many(events, CoreWeb.EventView, "event.json")}
  end

  def render("entity.json", %{entity: entity}) do
    %{
      links: [
        %{
          rel: "self",
          href: "/api/v1/entities/#{entity.id}"
        },
        %{
          rel: "properties",
          href: "/api/v1/entities/#{entity.id}/properties"
        },
        %{
          rel: "actions",
          href: "/api/v1/entities/#{entity.id}/actions"
        },
        %{
          rel: "events",
          href: "/api/v1/entities/#{entity.id}/events"
        }
      ],
      id: entity.id,
      attributes: %{
        name: entity.name,
        uuid: entity.uuid,
        description: entity.description,
        configuration: entity.configuration,
        label: entity.label,
        metadata: entity.metadata,
        state: entity.state,
        entity_type: render_one(entity.entity_type, EntityTypeView, "entity_type.json"),
        service:
          render_one(
            entity.service |> Core.Repo.preload([
              :provider,
              :property_types,
              :action_types,
              :event_types,
              :service_properties,
              :service_actions,
              :service_events
              ]),
            ServiceView,
            "service.json"
          ),
        properties:
          render_many(
            entity.property_types,
            __MODULE__,
            "property.json",
            as: :property
          ),
        actions:
          render_many(
            entity.action_types,
            __MODULE__,
            "action.json",
            as: :action
          ),
        events:
          render_many(
            entity.event_types,
            __MODULE__,
            "event.json",
            as: :event
          )
      }
    }
  end

  def render("property_state.json", %{value: value}) do
    value["value"]
  end

  def render("property.json", %{property: property}) do
    data =
      if property.property do
        property.property
      else
        %{}
      end

    %{
      links: [
        %{
          rel: "self",
          href: "/api/v1/entities/#{property.entity_id}/properties/#{property.id}"
        }
      ],
      id: property.id,
      title: property.title,
      description: data.description,
      type: data.type,
      name: data.name,
      values: data.values,
      units: data.units,
      readOnly: data.readOnly,
      state: property.state
    }
  end

  def render("action.json", %{action: action}) do
      if action.action do
        action.action
      else
        %{}
      end

    %{
      links: [
        %{
          rel: "self",
          href: "/api/v1/entities/#{action.entity_id}/actions/#{action.id}"
        }
      ],
      id: action.id
    }
  end

  def render("event.json", %{event: event}) do
      if event.event do
        event.event
      else
        %{}
      end

    %{
      links: [
        %{
          rel: "self",
          href: "/api/v1/entities/#{event.entity_id}/events/#{event.id}"
        }
      ],
      id: event.id
    }
  end
end
