defmodule Core.Web.LocationTypeView do
  use Core.Web, :view
  alias Core.Web.LocationTypeView

  def render("index.json", %{location_types: location_types}) do
    %{data: render_many(location_types, LocationTypeView, "location_type.json")}
  end

  def render("show.json", %{location_type: location_type}) do
    %{data: render_one(location_type, LocationTypeView, "location_type.json")}
  end

  def render("location_type.json", %{location_type: location_type}) do
    %{id: location_type.id,
      name: location_type.name,
      description: location_type.description}
  end
end
