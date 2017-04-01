
defmodule Core.ServiceView do
  use Core.Web, :view

  def render("index.json", %{services: services}) do
    %{
      data: render_many(services, Core.ServiceView, "service.json")
     }
  end

  def render("show.json", %{service: service}) do
    %{
      data: render_one(service, Core.ServiceView, "service.json")
      
    }
  end


  def render("service.json", %{service: service}) do
    %{

      id: service.id,
      links: %{
        self: "/api/v1/services/#{service.id}"
      },
      included: %{
        entities: render_many(service.entities |> Core.Repo.preload([:service]), Core.EntityView, "entity.json")
      },
      attributes: %{
          
          name: service.name,
          auth_method: service.provider.auth_method,
          provider_id: service.provider.id,
          provider_name: service.provider.name,
          client_id: service.client_id,
          client_secret: service.client_secret,
          access_token: service.access_token,
          api_key: service.api_key,
          enabled: service.enabled,
          searchable: service.searchable,
          search_path: service.search_path,
          state: service.state,
          slug: service.slug
        }
    }
  end
end
