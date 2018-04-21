defmodule CoreWeb.EventView do
  use CoreWeb, :view

  def render("index.json", %{events: events}) do
    %{
      links: %{
        self: "/api/v1/events"
      },
      data: render_many(events, CoreWeb.EventView, "event.json")
    }


  end

  def render("show.json", %{event: event}) do
    %{
      data: render_one(event, CoreWeb.EventView, "event.json")
    }
  end

  def render("event.json", %{event: event}) do

      %{
        links: %{
          self: "/api/v1/events/#{event.id}",
          logo: Core.EventManager.logo_url(event),
          icon: Core.EventManager.icon_url(event)
        },
        included: %{
          entity: render_one(event.entity |> Core.Repo.preload([:service]) , CoreWeb.EntityView, "entity.json")
        },
        id: event.id,
        attributes: %{
          subject: Core.EventManager.trimmed_title(event.message),
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
