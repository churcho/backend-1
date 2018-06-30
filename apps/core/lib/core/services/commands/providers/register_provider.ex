defmodule Core.Services.Commands.RegisterProvider do
  @moduledoc false

  defstruct [
    provider_uuid: "",
    name: "",
    description: "",
    url: "",
    enabled: "",
    auth_method: "",
    max_services: "",
    allows_import: "",
    version: "",
    keywords: "",
    logo_path: "",
    icon_path: "",
    slug: "",
  ]

  use ExConstructor
  use Vex.Struct

  alias Core.Services.Commands.RegisterProvider

  validates :provider_uuid, uuid: true

  @doc """
  Assign a unique identity to the provider
  """

  def assign_uuid(%RegisterProvider{} = register_provider, uuid) do
    %RegisterProvider{register_provider | provider_uuid: uuid}
  end
end
