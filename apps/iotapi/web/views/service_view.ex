defmodule Iotapi.ServiceView do
  use Iotapi.Web, :view

  def render("index.json", %{services: services}) do
    %{data: render_many(services, Iotapi.ServiceView, "service.json")}
  end

  def render("show.json", %{service: service}) do
    %{data: render_one(service, Iotapi.ServiceView, "service.json")}
  end

  def render("service.json", %{service: service}) do
    %{id: service.id,
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
      service_state: service.service_state}
  end
end
