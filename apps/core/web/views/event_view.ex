defmodule Iotapi.EventView do
  use Iotapi.Web, :view

  def render("index.json", %{events: events}) do
    %{
      links: %{
        self: "/api/v1/events"
      },
      data: render_many(events, Iotapi.EventView, "show.json")
    }


  end

  def render("show.json", %{event: event}) do
    %{
      links: %{
        self: "/api/v1/events/#{event.id}",
        logo: logo_url(event),
        icon: icon_url(event)
      },
      id: event.id,
      attributes: render_one(event, Iotapi.EventView, "event.json")
    }
  end

  def render("event.json", %{event: event}) do

      %{
        subject: trimmed_title(event.message),
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

  @doc """
  We will assemble the logo url using the event source field.
  """
  def logo_url(event) do
    if event.source do
      "http://localhost:4000/images/"<>event.source<>".png"
    else
      "http://localhost:4000/images/generic.png"
    end
  end

  def icon_url(event) do
    if event.source do
      "http://localhost:4000/images/"<>event.source<>"_icon.png"
    else
      "http://localhost:4000/images/generic_icon.png"
    end
  end

  @doc """
  Let's trim the message string down to a more manageable size.
  """
  def trimmed_title(title) do
    title
    |> String.slice(0..18)
    |> String.replace(~r{-[^-]*$}, "")
  end
end
