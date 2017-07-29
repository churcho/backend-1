defmodule CoreWeb.SettingView do
  use CoreWeb, :view

  def render("index.json", %{settings: settings}) do
    %{data: render_many(settings, CoreWeb.SettingView, "setting.json")}
  end

  def render("show.json", %{setting: setting}) do
    %{data: render_one(setting, CoreWeb.SettingView, "setting.json")}
  end

  def render("setting.json", %{setting: setting}) do
    %{id: setting.id,
      name: setting.name,
      value: setting.value,
      environment: setting.environment,
      user_id: setting.user_id,
      description: setting.description}
  end
end
