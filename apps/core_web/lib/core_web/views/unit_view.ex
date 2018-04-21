defmodule CoreWeb.UnitView do
  use CoreWeb, :view
  alias CoreWeb.UnitView

  def render("index.json", %{units: units}) do
    %{data: render_many(units, UnitView, "unit.json")}
  end

  def render("show.json", %{unit: unit}) do
    %{data: render_one(unit, UnitView, "unit.json")}
  end

  def render("unit.json", %{unit: unit}) do
    %{
      id: unit.id,
      name: unit.name,
      description: unit.description,
      symbol: unit.symbol,
      symbols: unit.symbols
    }
  end
end
