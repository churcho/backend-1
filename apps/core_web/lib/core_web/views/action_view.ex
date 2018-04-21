defmodule CoreWeb.ActionView do
  use CoreWeb, :view
  alias CoreWeb.ActionView

  def render("index.json", %{actions: actions}) do
    %{data: render_many(actions, ActionView, "action.json")}
  end

  def render("show.json", %{action: action}) do
    %{data: render_one(action, ActionView, "action.json")}
  end

  def render("action.json", %{action: action}) do
    %{
      payload: action.payload,
      time_requested: action.time_requested,
      time_completed: action.time_completed,
      time_status: action.status
    }
  end
end
