defmodule Core.EventView do
  use Core.Web, :view

  def render("index.json", %{events: events}) do
    %{
      links: %{
        self: "/api/v1/events"
      },
      data: render_many(events, Core.EventView, "event.json")
    }


  end

  def render("show.json", %{event: event}) do
    %{
      data: render_one(event, Core.EventView, "event.json")
    }
  end

  def render("event.json", %{event: event}) do

      %{
        links: %{
          self: "/api/v1/events/#{event.id}",
          logo: Core.Event.logo_url(event),
          icon: Core.Event.icon_url(event)
        },
        id: event.id,
        attributes: %{
          subject: Core.Event.trimmed_title(event.message),
          message: event.message,
          fields: event.permissions,
          uuid: event.uuid,
          value: event.value,
          units: event.units,
          date: event.date,
          service_id: event.service_id,
          entity_id: event.entity_id,
          expiration: event.expiration,
          source: event.source,
          source_event: event.source_event,
          type: event.type,
          state_changed: event.state_changed,
          payload: event.payload,
          metadata: event.metadata,
          inserted_at: event.inserted_at
        }
        

      }


  end

end
