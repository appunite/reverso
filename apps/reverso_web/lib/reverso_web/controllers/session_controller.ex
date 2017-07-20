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
    conn
    |> get_req_header("authorization")
    |> Accounts.fetch_by_token
    |> Accounts.delete_login_token()

    send_resp(conn, 200, "")
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
