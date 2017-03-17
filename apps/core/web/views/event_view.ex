defmodule Core.EventView do
  use Core.Web, :view

  def render("index.json", %{events: events}) do
    %{
      links: %{
        self: "/api/v1/events"
      },
      data: render_many(events, Core.EventView, "show.json")
    }


  end

  def render("show.json", %{event: event}) do
    %{
      links: %{
        self: "/api/v1/events/#{event.id}",
        logo: Core.Event.logo_url(event),
        icon: Core.Event.icon_url(event)
      },
      id: event.id,
      attributes: render_one(event, Core.EventView, "event.json")
    }
  end

  def render("event.json", %{event: event}) do

      %{
        subject: Core.Event.trimmed_title(event.message),
        message: event.message,
        entity: event.entity,
        value: event.value,
        units: event.units,
        date: event.date,
        source: event.source,
        type: event.type,
        state_changed: event.state_changed,
        payload: event.payload,
        inserted_at: event.inserted_at

      }


  end

end
