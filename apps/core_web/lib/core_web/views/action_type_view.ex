defmodule CoreWeb.ActionTypeView do
  use CoreWeb, :view
  alias CoreWeb.ActionTypeView

  def render("index.json", %{action_types: action_types}) do
    %{data: render_many(action_types, ActionTypeView, "action_type.json")}
  end

  def render("show.json", %{action_type: action_type}) do
    %{data: render_one(action_type, ActionTypeView, "action_type.json")}
  end

  def render("action_type.json", %{action_type: action_type}) do
    %{id: action_type.id,
      name: action_type.name,
      description: action_type.description}
  end
end
