defmodule Core.ProviderView do
  use Core.Web, :view

  def render("index.json", %{providers: providers}) do
    %{
      links: %{
        self: "/api/v1/providers"
      },
      data: render_many(providers, Core.ProviderView, "show.json")
    }
  end

  def render("show.json", %{provider: provider}) do
    %{
      links: %{
        self: "/api/v1/providers/#{provider.id}"
      },
      id: provider.id,
      attributes: render_one(provider, Core.ProviderView, "provider.json")
    }
  end

  def render("provider.json", %{provider: provider}) do
    %{

      name: provider.name,
      url: provider.url,
      description: provider.description,
      enabled: provider.enabled,
      lorp_name: provider.lorp_name,
      registered_at:  provider.registered_at,
      last_seen: provider.last_seen,
      provides: provider.provides,
      configuration: provider.configuration,
      keywords: provider.keywords,
      version: provider.version
    }
  end
end