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
    service_name: nil,
    allows_import: nil,
    version: nil,
    required_fields: nil,
    commands: nil,
    keywords: nil,
    logo_path: nil,
    icon_path: nil,
    slug: nil,
  ]

  alias Core.Services.Aggregates.Provider
  alias Core.Services.Commands.{
    RegisterProvider,
    UpdateProvider
  }
  alias Core.Services.Events.{
    ProviderRegistered,
    ProviderNameChanged,
    ProviderDescriptionChanged,
    ProviderUrlChanged,
    ProviderEnabledChanged,
    ProviderAuthMethodChanged,
    ProviderMaxServicesChanged,
    ProviderServiceNameChanged,
    ProviderAllowsImportChanged,
    ProviderVersionChanged,
    ProviderRequiredFieldsChanged,
    ProviderCommandsChanged,
    ProviderKeywordsChanged,
    ProviderLogoPathChanged,
    ProviderIconPathChanged,
    ProviderSlugChanged
  }

  def execute(%Provider{uuid: nil}, %RegisterProvider{} = register) do
    %ProviderRegistered{
      provider_uuid: register.provider_uuid,
      name: register.name,
      description: register.description,
      url: register.url,
      enabled: register.enabled,
      auth_method: register.auth_method,
      max_services: register.max_services,
      service_name: register.service_name,
      allows_import: register.allows_import,
      version: register.version,
      required_fields: register.required_fields,
      commands: register.commands,
      keywords: register.keywords,
      logo_path: register.logo_path,
      icon_path: register.icon_path,
      slug: register.slug
    }
  end

  @doc """
  Update a provider's name, description
  """
  def execute(%Provider{} = provider, %UpdateProvider{} = update) do
    Enum.reduce([
      &name_changed/2,
      &description_changed/2,
      &url_changed/2,
      &enabled_changed/2,
      &auth_method_changed/2,
      &max_services_changed/2,
      &service_name_changed/2,
      &allows_import_changed/2,
      &version_changed/2,
      &required_fields_changed/2,
      &commands_changed/2,
      &keywords_changed/2,
      &logo_path_changed/2,
      &icon_path_changed/2,
      &slug_changed/2
      ], [], fn (change, events) ->
      case change.(provider, update) do
        nil -> events
        event -> [event | events]
      end
    end)
  end

  # state mutators

  def apply(%Provider{} = provider, %ProviderRegistered{} = created) do
    %Provider{provider |
      uuid: created.provider_uuid,
      name: created.name,
      description: created.description,
      url: created.url,
      enabled: created.enabled,
      auth_method: created.auth_method,
      max_services: created.max_services,
      service_name: created.service_name,
      allows_import: created.allows_import,
      version: created.version,
      required_fields: created.required_fields,
      commands: created.commands,
      keywords: created.keywords,
      logo_path: created.logo_path,
      icon_path: created.icon_path,
      slug: created.slug
    }
  end

  def apply(%Provider{} = provider, %ProviderNameChanged{name: name}) do
    %Provider{provider | name: name}
  end

  def apply(%Provider{} = provider, %ProviderDescriptionChanged{description: description}) do
    %Provider{provider | description: description}
  end

  def apply(%Provider{} = provider, %ProviderUrlChanged{url: url}) do
    %Provider{provider | url: url}
  end

  def apply(%Provider{} = provider, %ProviderEnabledChanged{enabled: enabled}) do
    %Provider{provider | enabled: enabled}
  end

  def apply(%Provider{} = provider, %ProviderAuthMethodChanged{auth_method: auth_method}) do
    %Provider{provider | auth_method: auth_method}
  end

  def apply(%Provider{} = provider, %ProviderMaxServicesChanged{max_services: max_services}) do
    %Provider{provider | max_services: max_services}
  end

  def apply(%Provider{} = provider, %ProviderServiceNameChanged{service_name: service_name}) do
    %Provider{provider | service_name: service_name}
  end

  def apply(%Provider{} = provider, %ProviderAllowsImportChanged{allows_import: allows_import}) do
    %Provider{provider | allows_import: allows_import}
  end

  def apply(%Provider{} = provider, %ProviderVersionChanged{version: version}) do
    %Provider{provider | version: version}
  end

  def apply(%Provider{} = provider, %ProviderRequiredFieldsChanged{required_fields: required_fields}) do
    %Provider{provider | required_fields: required_fields}
  end

  def apply(%Provider{} = provider, %ProviderCommandsChanged{commands: commands}) do
    %Provider{provider | commands: commands}
  end

  def apply(%Provider{} = provider, %ProviderKeywordsChanged{keywords: keywords}) do
    %Provider{provider | keywords: keywords}
  end

  def apply(%Provider{} = provider, %ProviderLogoPathChanged{logo_path: logo_path}) do
    %Provider{provider | logo_path: logo_path}
  end

  def apply(%Provider{} = provider, %ProviderIconPathChanged{icon_path: icon_path}) do
    %Provider{provider | icon_path: icon_path}
  end

  def apply(%Provider{} = provider, %ProviderSlugChanged{slug: slug}) do
    %Provider{provider | slug: slug}
  end

  # private helpers

  defp name_changed(%Provider{}, %UpdateProvider{name: ""}), do: nil
  defp name_changed(%Provider{name: name}, %UpdateProvider{name: name}), do: nil
  defp name_changed(%Provider{uuid: provider_uuid}, %UpdateProvider{name: name}) do
    %ProviderNameChanged{
      provider_uuid: provider_uuid,
      name: name,
    }
  end

  defp description_changed(%Provider{}, %UpdateProvider{description: ""}), do: nil
  defp description_changed(%Provider{description: description}, %UpdateProvider{description: description}), do: nil
  defp description_changed(%Provider{uuid: provider_uuid}, %UpdateProvider{description: description}) do
    %ProviderDescriptionChanged{
      provider_uuid: provider_uuid,
      description: description,
    }
  end

  defp url_changed(%Provider{}, %UpdateProvider{url: ""}), do: nil
  defp url_changed(%Provider{url: url}, %UpdateProvider{url: url}), do: nil
  defp url_changed(%Provider{uuid: provider_uuid}, %UpdateProvider{url: url}) do
    %ProviderUrlChanged{
      provider_uuid: provider_uuid,
      url: url,
    }
  end

  defp enabled_changed(%Provider{}, %UpdateProvider{enabled: ""}), do: nil
  defp enabled_changed(%Provider{enabled: enabled}, %UpdateProvider{enabled: enabled}), do: nil
  defp enabled_changed(%Provider{uuid: provider_uuid}, %UpdateProvider{enabled: enabled}) do
    %ProviderEnabledChanged{
      provider_uuid: provider_uuid,
      enabled: enabled,
    }
  end

  defp auth_method_changed(%Provider{}, %UpdateProvider{auth_method: ""}), do: nil
  defp auth_method_changed(%Provider{auth_method: auth_method}, %UpdateProvider{auth_method: auth_method}), do: nil
  defp auth_method_changed(%Provider{uuid: provider_uuid}, %UpdateProvider{auth_method: auth_method}) do
    %ProviderAuthMethodChanged{
      provider_uuid: provider_uuid,
      auth_method: auth_method,
    }
  end

  defp max_services_changed(%Provider{}, %UpdateProvider{max_services: ""}), do: nil
  defp max_services_changed(%Provider{max_services: max_services}, %UpdateProvider{max_services: max_services}), do: nil
  defp max_services_changed(%Provider{uuid: provider_uuid}, %UpdateProvider{max_services: max_services}) do
    %ProviderMaxServicesChanged{
      provider_uuid: provider_uuid,
      max_services: max_services,
    }
  end

  defp service_name_changed(%Provider{}, %UpdateProvider{service_name: ""}), do: nil
  defp service_name_changed(%Provider{service_name: service_name}, %UpdateProvider{service_name: service_name}), do: nil
  defp service_name_changed(%Provider{uuid: provider_uuid}, %UpdateProvider{service_name: service_name}) do
    %ProviderServiceNameChanged{
      provider_uuid: provider_uuid,
      service_name: service_name,
    }
  end

  defp allows_import_changed(%Provider{}, %UpdateProvider{allows_import: ""}), do: nil
  defp allows_import_changed(%Provider{allows_import: allows_import}, %UpdateProvider{allows_import: allows_import}), do: nil
  defp allows_import_changed(%Provider{uuid: provider_uuid}, %UpdateProvider{allows_import: allows_import}) do
    %ProviderAllowsImportChanged{
      provider_uuid: provider_uuid,
      allows_import: allows_import,
    }
  end

  defp version_changed(%Provider{}, %UpdateProvider{version: ""}), do: nil
  defp version_changed(%Provider{version: version}, %UpdateProvider{version: version}), do: nil
  defp version_changed(%Provider{uuid: provider_uuid}, %UpdateProvider{version: version}) do
    %ProviderVersionChanged{
      provider_uuid: provider_uuid,
      version: version,
    }
  end

  defp required_fields_changed(%Provider{}, %UpdateProvider{required_fields: ""}), do: nil
  defp required_fields_changed(%Provider{required_fields: required_fields}, %UpdateProvider{required_fields: required_fields}), do: nil
  defp required_fields_changed(%Provider{uuid: provider_uuid}, %UpdateProvider{required_fields: required_fields}) do
    %ProviderRequiredFieldsChanged{
      provider_uuid: provider_uuid,
      required_fields: required_fields,
    }
  end

  defp commands_changed(%Provider{}, %UpdateProvider{commands: ""}), do: nil
  defp commands_changed(%Provider{commands: commands}, %UpdateProvider{commands: commands}), do: nil
  defp commands_changed(%Provider{uuid: provider_uuid}, %UpdateProvider{commands: commands}) do
    %ProviderCommandsChanged{
      provider_uuid: provider_uuid,
      commands: commands,
    }
  end

  defp keywords_changed(%Provider{}, %UpdateProvider{keywords: ""}), do: nil
  defp keywords_changed(%Provider{keywords: keywords}, %UpdateProvider{url: keywords}), do: nil
  defp keywords_changed(%Provider{uuid: provider_uuid}, %UpdateProvider{keywords: keywords}) do
    %ProviderKeywordsChanged{
      provider_uuid: provider_uuid,
      keywords: keywords,
    }
  end

  defp logo_path_changed(%Provider{}, %UpdateProvider{logo_path: ""}), do: nil
  defp logo_path_changed(%Provider{logo_path: logo_path}, %UpdateProvider{logo_path: logo_path}), do: nil
  defp logo_path_changed(%Provider{uuid: provider_uuid}, %UpdateProvider{logo_path: logo_path}) do
    %ProviderLogoPathChanged{
      provider_uuid: provider_uuid,
      logo_path: logo_path,
    }
  end

  defp icon_path_changed(%Provider{}, %UpdateProvider{icon_path: ""}), do: nil
  defp icon_path_changed(%Provider{icon_path: icon_path}, %UpdateProvider{icon_path: icon_path}), do: nil
  defp icon_path_changed(%Provider{uuid: provider_uuid}, %UpdateProvider{icon_path: icon_path}) do
    %ProviderIconPathChanged{
      provider_uuid: provider_uuid,
      icon_path: icon_path,
    }
  end

  defp slug_changed(%Provider{}, %UpdateProvider{slug: ""}), do: nil
  defp slug_changed(%Provider{slug: slug}, %UpdateProvider{slug: slug}), do: nil
  defp slug_changed(%Provider{uuid: provider_uuid}, %UpdateProvider{slug: slug}) do
    %ProviderSlugChanged{
      provider_uuid: provider_uuid,
      slug: slug,
    }
  end
end
