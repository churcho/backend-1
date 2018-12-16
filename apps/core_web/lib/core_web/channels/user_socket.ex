defmodule CoreWeb.UserSocket do
  use Phoenix.Socket

  alias Core.Auth.GuardianSerializer
  # Channels
  channel "events:*", CoreWeb.EventChannel
  channel "users:*", CoreWeb.UserChannel
  channel "locations:*", CoreWeb.PlacesLocationsChannel
  channel "zones:*", CoreWeb.PlacesZonesChannel
  channel "rooms:*", CoreWeb.PlacesRoomsChannel
  # Transports

  def connect(%{"token" => token}, socket) do
    case CoreWeb.Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        case GuardianSerializer.from_token(claims["sub"]) do
          {:ok, user} ->
            {:ok, assign(socket, :current_user, user)}
          {:error, _reason} ->
            :error
        end
      {:error, _reason} ->
        :error
    end
  end

  def connect(_params, _socket), do: :error

  def id(socket), do: "users_socket:#{socket.assigns.current_user.id}"
end
