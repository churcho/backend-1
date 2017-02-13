defmodule Iotapi.EventView do
  use Iotapi.Web, :view

  def render("index.json", %{events: events}) do
    %{
      links: %{
        self: "/api/v1/events"
      },
      data: render_many(events, Iotapi.EventView, "event.json")
    }


  end

  def render("show.json", %{event: event}) do
    %{
      links: %{
        self: "/api/v1/events/#{event.id}"
      },
      data: render_one(event, Iotapi.EventView, "event.json")
    }
  end

  def render("event.json", %{event: event}) do

      %{
        id: event.id,
        message: event.message,
        entity: event.entity,
        value: event.value,
        units: event.units,
        date: event.date,
        source: event.source,
        type: event.type,
        state_changed: event.state_changed,
        payload: event.payload

      }


  end
end
