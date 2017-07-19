defmodule Reverso.Web.SessionController do
  use Reverso.Web, :controller

  alias Reverso.Accounts
  alias Reverso.Accounts.User

  action_fallback Reverso.Web.FallbackController

  def create(conn, %{"params" => session_params}) do
    case Accounts.login(session_params) do
      {:ok, %User{} = user } ->
        conn
        |> put_resp_header("authorization", user.user_token)
        |> render("user.json", user: user)
      {:invalid_credentials} ->
        conn
        |> put_status(401)
        |> render("invalid_creds.json", %{error: "Invalid credentials!"})
    end
  end

  def delete(conn, _params) do
    conn
    |> get_resp_header("authorization")
    |> Accounts.fetch_by_token
    |> Accounts.delete_login_token()
  end
end