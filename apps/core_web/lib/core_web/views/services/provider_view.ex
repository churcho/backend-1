defmodule CoreWeb.ProviderView do
  use CoreWeb, :view

  def render("index.json", %{providers: providers}) do
    %{
      links: %{self: "/api/v1/services/providers"},
      data: render_many(providers, CoreWeb.ProviderView, "provider.json")
    }
  end

  def render("show.json", %{provider: provider}) do
    %{
      data: render_one(provider, CoreWeb.ProviderView, "provider.json")
    }
  end

  def render("provider.json", %{provider: provider}) do
    %{
      links: %{
        self: "/api/v1/services/providers/#{provider.uuid}"
      },
      uuid: provider.uuid,
      name: provider.name,
      description: provider.description,
      required_fields: provider.required_fields,
      commands: provider.commands
    }
end
end
