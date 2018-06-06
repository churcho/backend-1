defmodule CoreWeb.SwitchView do
  use CoreWeb, :view
  alias CoreWeb.SwitchView

  def render("index.json", %{switches: switches}) do
    %{data: render_many(switches, SwitchView, "switch.json")}
  end

  def render("show.json", %{switch: switch}) do
    %{data: render_one(switch, SwitchView, "switch.json")}
  end

  def render("switch.json", %{switch: switch}) do
    %{id: switch.id,
      on: switch.on}
  end
end
