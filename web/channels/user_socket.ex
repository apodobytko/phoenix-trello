defmodule PhoenixTrello.UserSocket do
  use Phoenix.Socket

  alias PhoenixTrello.{GuardianSerializer}

  # Channels
  channel "boards:*", PhoenixTrello.BoardChannel
  channel "users:*", PhoenixTrello.UserChannel

  # Transports
  transport :websocket, Phoenix.Transports.WebSocket
  transport :longpoll, Phoenix.Transports.LongPoll

  def connect(%{"token" => token}, socket) do
    case Guardian.decode_and_verify(token) do
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

  def id(%{assigns: %{current_user: current_user}} = _socket) do
    socket_id =
      if current_user do
        current_user.id
      else
        nil
      end

    "users_socket:#{socket_id}"
  end
end
