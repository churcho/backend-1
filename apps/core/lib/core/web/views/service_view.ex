defmodule Core.Web.ServiceView do
  use Core.Web, :view

  def render("index.json", %{services: services}) do
    %{
      data: render_many(services, Core.Web.ServiceView, "service.json")
     }
  end

  def render("show.json", %{service: service}) do
    %{
      data: render_one(service, Core.Web.ServiceView, "service.json")
    }
  end

  def render("show_event.json", %{event: event}) do
    %{data: render_one(event, Core.Web.EventView, "event.json")}
  end

  def render("service_events.json", %{events: events}) do
    %{data: render_many(events, Core.Web.EventView, "event.json")}
  end


  def render("service.json", %{service: service}) do
    %{

      id: service.id,
      links: %{
        self: "/api/v1/services/#{service.id}"
      },
      included: %{
        entities: render_many(service.entities |> Core.Repo.preload([:service]), Core.Web.EntityView, "entity.json")
      },
      attributes: %{

          name: service.name,
          host: service.host,
          port: service.port,
          auth_method: service.provider.auth_method,
          provider_id: service.provider.id,
          provider_name: service.provider.name,
          provider_config: service.provider.configuration,
          client_id: service.client_id,
          client_secret: service.client_secret,
          access_token: service.access_token,
          api_key: service.api_key,
          enabled: service.enabled,
          requires_authorization: service.requires_authorization,
          allows_import: service.allows_import,
          imported_at: service.imported_at,
          authorized: service.authorized,
          searchable: service.searchable,
          search_path: service.search_path,
          state: service.state,
          configuration: service.configuration,
          metadata: service.metadata,
          slug: service.slug
        }
    }
  end
end
