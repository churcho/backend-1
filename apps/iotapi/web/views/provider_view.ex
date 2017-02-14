defmodule Iotapi.ProviderView do
  use Iotapi.Web, :view

  def render("index.json", %{providers: providers}) do
    %{
      links: %{
        self: "/api/v1/providers"
      },
      data: render_many(providers, Iotapi.ProviderView, "show.json")
    }
  end

  def render("show.json", %{provider: provider}) do
    %{
      links: %{
        self: "/api/v1/providers/#{provider.id}"
      },
      id: provider.id,
      attributes: render_one(provider, Iotapi.ProviderView, "provider.json")
    }
  end

  def render("provider.json", %{provider: provider}) do
    %{

      name: provider.name,
      uri: provider.uri,

    }
  end
end
