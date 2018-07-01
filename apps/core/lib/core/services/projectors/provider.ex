defmodule Core.Services.Projectors.Provider do
  @moduledoc false
  use Commanded.Projections.Ecto,
    name: "Services.Projectors.Provider",
    consistency: :strong

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
  alias Core.Services.Projections.Provider
  alias Ecto.Multi

  project %ProviderRegistered{} = registered do
    Multi.insert(multi, :provider, %Provider{
      uuid: registered.provider_uuid,
      name: registered.name,
      description: registered.description,
      url: registered.url,
      enabled: registered.enabled,
      auth_method: registered.auth_method,
      max_services: registered.max_services,
      service_name: registered.service_name,
      allows_import: registered.allows_import,
      version: registered.version,
      required_fields: registered.required_fields,
      commands: registered.commands,
      keywords: registered.keywords,
      logo_path: registered.logo_path,
      icon_path: registered.icon_path,
      slug: registered.slug
    })
  end

  project %ProviderNameChanged{
    provider_uuid: provider_uuid, name: name}
  do
    update_provider(multi, provider_uuid, name: name)
  end

  project %ProviderDescriptionChanged{
    provider_uuid: provider_uuid, description: description}
  do
    update_provider(multi, provider_uuid, description: description)
  end

  project %ProviderUrlChanged{
    provider_uuid: provider_uuid, url: url}
  do
    update_provider(multi, provider_uuid, url: url)
  end

  project %ProviderEnabledChanged{
    provider_uuid: provider_uuid, enabled: enabled}
  do
    update_provider(multi, provider_uuid, enabled: enabled)
  end

  project %ProviderAuthMethodChanged{
    provider_uuid: provider_uuid, auth_method: auth_method}
  do
    update_provider(multi, provider_uuid, auth_method: auth_method)
  end

  project %ProviderMaxServicesChanged{
    provider_uuid: provider_uuid, max_services: max_services}
  do
    update_provider(multi, provider_uuid, max_services: max_services)
  end

  project %ProviderServiceNameChanged{
    provider_uuid: provider_uuid, service_name: service_name}
  do
    update_provider(multi, provider_uuid, service_name: service_name)
  end

  project %ProviderAllowsImportChanged{
    provider_uuid: provider_uuid, allows_import: allows_import}
  do
    update_provider(multi, provider_uuid, allows_import: allows_import)
  end

  project %ProviderVersionChanged{
    provider_uuid: provider_uuid, version: version}
  do
    update_provider(multi, provider_uuid, version: version)
  end

  project %ProviderRequiredFieldsChanged{
    provider_uuid: provider_uuid, required_fields: required_fields}
  do
    update_provider(multi, provider_uuid, required_fields: required_fields)
  end

  project %ProviderCommandsChanged{
    provider_uuid: provider_uuid, commands: commands}
  do
    update_provider(multi, provider_uuid, commands: commands)
  end

  project %ProviderKeywordsChanged{
    provider_uuid: provider_uuid, keywords: keywords}
  do
    update_provider(multi, provider_uuid, keywords: keywords)
  end

  project %ProviderIconPathChanged{
    provider_uuid: provider_uuid, icon_path: icon_path}
  do
    update_provider(multi, provider_uuid, icon_path: icon_path)
  end

  project %ProviderLogoPathChanged{
    provider_uuid: provider_uuid, logo_path: logo_path}
  do
    update_provider(multi, provider_uuid, logo_path: logo_path)
  end


  project %ProviderSlugChanged{
    provider_uuid: provider_uuid, slug: slug}
  do
    update_provider(multi, provider_uuid, slug: slug)
  end

  defp provider_query(provider_uuid) do
    from(p in Provider, where: p.uuid == ^provider_uuid)
  end

  defp update_provider(multi, provider_uuid, changes) do
    Multi.update_all(
      multi, :provider, provider_query(provider_uuid), set: changes
      )
  end

end
