
defmodule Core.Services.Commands.UpdateProvider do
  @moduledoc """
  Command to update provider
  """

  defstruct [
    provider_uuid: "",
    name: "",
    description: "",
    url: "",
    enabled: "",
    auth_method: "",
    max_services: "",
    service_name: "",
    allows_import: "",
    version: "",
    required_fields: "",
    commands: "",
    keywords: "",
    logo_path: "",
    icon_path: "",
    slug: "",
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Services.Commands.UpdateProvider
  alias Core.Services.Projections.Provider

  validates :provider_uuid, uuid: true

  @doc """
  Assign the Provider identity
  """
  def assign_provider(%UpdateProvider{} = update_provider, %Provider{uuid: provider_uuid}) do
    %UpdateProvider{update_provider | provider_uuid: provider_uuid}
  end
end
