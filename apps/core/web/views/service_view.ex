
defmodule Core.ServiceView do
  use Core.Web, :view

  def render("index.json", %{services: services}) do
    %{data: render_many(services, Core.ServiceView, "show.json")}
  end

  def render("show.json", %{service: service}) do
    %{
      id: service.id,
      links: %{
        self: "/api/v1/services/#{service.id}"
      },
      attributes: render_one(service, Core.ServiceView, "service.json"),
      included: render_one(service.provider, Core.ProviderView, "show.json"),
    }
  end

  def render("created.json", %{service: service}) do
  

    %{
     type: "services",
     id: service.id,
     attributes: render_one(service, Core.ServiceView, "service.json"),
     links: %{
       self: "/api/v1/services/#{service.id}"
     },


   }
  end

  def render("service.json", %{service: service}) do
    %{
      name: service.name,
      client_id: service.client_id,
      client_secret: service.client_secret,
      access_token: service.access_token,
      url: service.url,
      oauth: service.oauth,
      bridge: service.bridge,
      enabled: service.enabled,
      type: service.type,
      search_path: service.search_path,
      service_state: service.service_state
    }
  end
end
