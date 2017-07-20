defmodule Reverso.Web.SessionController do
  use Reverso.Web, :controller

  alias Reverso.Accounts
  alias Reverso.Accounts.User

  action_fallback Reverso.Web.FallbackController

  def create(conn, %{"params" => session_params}) do
    case Accounts.login(session_params) do
      {:ok, %User{} = user } ->
        conn
        |> put_status(200)
        |> render("session.json", user: user)
      {:error, :invalid_credentials} ->
        conn
        |> put_status(401)
        |> render("invalid_creds.json", %{error: "Invalid credentials!"})
      {:error, :user_not_activated} ->
        conn
        |> put_status(401)
        |> render("invalid_creds.json", %{error: "User not activated!"})
    end
  end

  def delete(conn, _params) do
    with {:ok, :logged_out} <- Accounts.logout(conn.assigns[:current_user_id]) do
      send_resp(conn, 200, "Logged out!")
    else
      _ -> send_resp(conn, 401, "User with specified token not found!")
    end

  end

  # THIS WILL BE CHANGED
  def generate_activation_url(%User{} = user) do
    ["localhost:4000/api/activate/?token=", user.activation_token]
    |> Enum.join
  end

  def generate_password_reset_url(%User{} = user) do
    ["localhost:4000/api/resetpassword/?token=", user.password_reset_token]
    |> Enum.join
  end
end
