defmodule Core.Services.Aggregates.Provider do
  @moduledoc false

  defstruct [
    uuid: nil,
    name: nil,
    description: nil,
    url: nil,
    enabled: nil,
    auth_method: nil,
    max_services: nil,
    allows_import: nil,
    version: nil,
    keywords: nil,
    logo_path: nil,
    icon_path: nil,
    slug: nil,
  ]

  alias Core.Services.Aggregates.Provider
  alias Core.Services.Commands.{
    RegisterProvider
  }
  alias Core.Services.Events.{
    ProviderRegistered
  }

  def execute(%Provider{uuid: nil}, %RegisterProvider{} = register) do
    %ProviderRegistered{
      provider_uuid: register.uuid,
      name: register.name,
      description: register.description
    }
  end
  # state mutators

  def apply(%Provider{} = provider, %ProviderRegistered{} = created) do
    %Provider{provider |
      uuid: created.author_uuid,
      name: created.name,
      description: created.description
    }
  end

  # private helpers


end
