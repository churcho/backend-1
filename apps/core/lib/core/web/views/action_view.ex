defmodule Core.Web.ActionView do
  use Core.Web, :view
  alias Core.Web.ActionView

  def render("index.json", %{actions: actions}) do
    %{data: render_many(actions, ActionView, "action.json")}
  end

  def render("show.json", %{action: action}) do
    %{data: render_one(action, ActionView, "action.json")}
  end

  def render("action.json", %{action: action}) do
    %{id: action.id,
      name: action.name}
  end
end
