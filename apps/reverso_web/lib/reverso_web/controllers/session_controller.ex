defmodule Reverso.Web.SessionController do
  use Reverso.Web, :controller

  alias Reverso.Accounts
  alias Reverso.Accounts.User

  action_fallback Reverso.Web.FallbackController

  def create(conn, %{"params" => session_params}) do
    with {:ok, %User{} = user } <- Accounts.login(session_params) do
          Reverso.Web.UserView.render("show.json", user: user)
          conn
          |> put_resp_header("authorization", user.user_token)
          |> send_resp(200, "Logged In")
    end
  end

  def delete(conn, _params) do
    conn
    |> get_resp_header("authorization")
    |> Accounts.fetch_by_token
    |> Accounts.delete_login_token()
  end
end