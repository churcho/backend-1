defmodule Core.Services.Commands.RegisterProvider do
  @moduledoc false

  defstruct [
    provider_uuid: "",
    name: "",
    description: "",
    url: "",
    enabled: nil,
    auth_method: nil,
    max_services: nil,
    service_name: "",
    allows_import: nil,
    version: "",
    required_fields: nil,
    commands: nil,
    keywords: nil,
    logo_path: "",
    icon_path: "",
    slug: "",
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Services.Commands.RegisterProvider

  validates :provider_uuid, uuid: true

  def assign_uuid(%RegisterProvider{} = register_provider, uuid) do
    %RegisterProvider{register_provider | provider_uuid: uuid}
  end
end
