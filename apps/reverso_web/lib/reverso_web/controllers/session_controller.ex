defmodule Reverso.Web.SessionController do
  use Reverso.Web, :controller

  alias Reverso.Accounts
  alias Reverso.Accounts.User

  action_fallback Reverso.Web.FallbackController

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn,%{"email" => user_email, "password" => user_password} = session_params) do
    IO.inspect session_params
    with {:ok, %User{} = user } <- Accounts.login(session_params),                    #to w jedno zrobic
         {:ok, %User{} = user_with_token} <- Accounts.create_login_token(user) do
          conn
          |> put_resp_header("authorization", user_with_token.user_token)
          |> render("token.json", user: user_with_token)
    end
  end

  def delete(conn, _params) do
    conn
    |> get_resp_header("authorization")
    |> Accounts.fetch_by_token
    |> Accounts.delete_login_token()
  end
end