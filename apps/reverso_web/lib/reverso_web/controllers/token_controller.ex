defmodule Reverso.Web.TokenController do
  use Reverso.Web, :controller

  alias Reverso.Accounts
  alias Reverso.Accounts.User

  def password_reset(conn, %{"token" => token, "new_password" => new_password} = params) do
    case Accounts.reset_password(token, new_password) do
      {:ok, struct} ->
        conn
        |> send_resp(200, "Password changed!")
      {:user_not_found, _} ->
        conn
        |> send_resp(401, "User not found!")
    end
  end

  def activate_account(conn, %{"token" => token} = params) do
    case Accounts.activate(token) do
      {:ok, struct} ->
        conn
        |> send_resp(200, "User activated!")
      {:user_not_found, _} ->
        conn
        |> send_resp(401, "User not found!")
    end
  end
end
