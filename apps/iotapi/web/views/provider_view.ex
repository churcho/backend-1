defmodule Iotapi.ProviderView do
  use Iotapi.Web, :view

  def render("index.json", %{providers: providers}) do
    %{data: render_many(providers, Iotapi.ProviderView, "provider.json")}
  end

  def render("show.json", %{provider: provider}) do
    %{data: render_one(provider, Iotapi.ProviderView, "provider.json")}
  end

  def render("provider.json", %{provider: provider}) do
    %{id: provider.id,
      name: provider.name,
      uri: provider.uri,
      callback_uri: provider.callback_uri}
  end
end
