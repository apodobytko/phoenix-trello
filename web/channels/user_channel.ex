defmodule PhoenixTrello.UserChannel do
  use PhoenixTrello.Web, :channel

  def join("users:" <> user_id, _params, %{assigns: %{current_user: current_user}} = socket) do
    current_user_id =
      if current_user do
        current_user.id
      else
        nil
      end

    if String.to_integer(user_id) == current_user_id do
      {:ok, socket}
    else
      {:error, %{reason: "Invalid user"}}
    end
  end
end
