defmodule CoreWeb.ServiceView do
  use CoreWeb, :view

  def render("index.json", %{services: services}) do
    %{
      links: [
        %{
          rel: "self",
          href: "/api/v1/services"
        }
      ],
      services: render_many(services, CoreWeb.ServiceView, "service.json")
    }
  end

  def render("properties_index.json", %{service: service}) do
    %{
      links: [
        %{
          rel: "self",
          href: "/api/v1/services/#{service.id}/properties",
          type: "GET"
        }
      ],
      properties:
        render_many(
          service.property_types,
          __MODULE__,
          "property.json",
          as: :property
        )
    }
  end

  def render("actions_index.json", %{service: service}) do
    %{
      links: [
        %{
          rel: "self",
          href: "/api/v1/entities/#{service.id}/actions",
          type: "GET"
        }
      ],
      actions:
        render_many(
          service.action_types,
          __MODULE__,
          "action.json",
          as: :action
        )
    }
  end

  def render("events_index.json", %{service: service}) do
    %{
      links: [
        %{
          rel: "self",
          href: "/api/v1/services/#{service.id}/events",
          type: "GET"
        }
      ],
      actions:
        render_many(
          service.event_types,
          __MODULE__,
          "event.json",
          as: :event
        )
    }
  end

  def render("show.json", %{service: service}) do
    %{
      data: render_one(service, CoreWeb.ServiceView, "service.json")
    }
  end

  def render("show_event.json", %{event: event}) do
    %{data: render_one(event, CoreWeb.EventView, "event.json")}
  end

  def render("service_events.json", %{events: events}) do
    %{data: render_many(events, CoreWeb.EventView, "event.json")}
  end

  def render("service.json", %{service: service}) do
    %{
      id: service.id,
      links: [
        %{
          rel: "self",
          href: "/api/v1/services/#{service.id}"
        },
        %{
          rel: "properties",
          href: "/api/v1/services/#{service.id}/properties"
        },
        %{
          rel: "actions",
          href: "/api/v1/services/#{service.id}/actions"
        },
        %{
          rel: "events",
          href: "/api/v1/services/#{service.id}/events"
        }
      ],
      attributes: %{
        name: service.name,
        description: service.description,
        host: service.host,
        port: service.port,
        auth_method: service.provider.auth_method,
        allows_import: service.provider.allows_import,
        provider_id: service.provider.id,
        provider_name: service.provider.name,
        provider_config: service.provider.configuration,
        client_id: service.client_id,
        client_secret: service.client_secret,
        access_token: service.access_token,
        api_key: service.api_key,
        enabled: service.enabled,
        imported_at: service.imported_at,
        authorized: service.authorized,
        state: service.state,
        configuration: service.configuration,
        metadata: service.metadata,
        slug: service.slug,
        properties:
          render_many(
            service.property_types,
            __MODULE__,
            "property.json",
            as: :property
          ),
        actions:
          render_many(
            service.action_types,
            __MODULE__,
            "action.json",
            as: :action
          ),
        events:
          render_many(
            service.event_types,
            __MODULE__,
            "event.json",
            as: :event
          )
      }
    }
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
          href: "/api/v1/services/#{property.service_id}/properties/#{property.id}"
        }
      ],
      id: property.id,
      description: data.description,
      type: data.type,
      name: data.name,
      values: data.values,
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
          href: "/api/v1/services/#{action.service_id}/actions/#{action.id}"
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
          href: "/api/v1/entities/#{event.service_id}/events/#{event.id}"
        }
      ],
      id: event.id
    }
  end
end
