defmodule CoreWeb.ProviderView do
  use CoreWeb, :view

  def render("index.json", %{providers: providers}) do
    %{
      links: %{
        self: "/api/v1/providers"
      },
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
        self: "/api/v1/providers/#{provider.id}"
      },
      id: provider.id,
      included: %{
       services: render_many(provider.services |> Core.Repo.preload([:provider, :entities]), CoreWeb.ServiceView, "service.json")
      },
      attributes: %{
        name: provider.name,
        description: provider.description,
        url: provider.url,
        enabled: provider.enabled,
        lorp_name: provider.lorp_name,
        auth_method: provider.auth_method,
        registered_at:  provider.registered_at,
        last_seen: provider.last_seen,
        provides: provider.provides,
        max_services: provider.max_services,
        configuration: provider.configuration,
        logo_path: provider.logo_path,
        icon_path: provider.icon_path,
        keywords: provider.keywords,
        version: provider.version,
        slug: provider.slug
      }

    }

  end
end
