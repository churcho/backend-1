defmodule CoreWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :CoreWeb,
  module: CoreWeb.Guardian,
  error_handler: CoreWeb.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
