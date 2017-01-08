defmodule Iotapi.EventView do
  use Iotapi.Web, :view

  def render("index.json", %{events: events}) do
    %{data: render_many(events, Iotapi.EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, Iotapi.EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      message: event.message,
      entity: event.entity,
      type: event.type,
      payload: event.payload}
  end
end
