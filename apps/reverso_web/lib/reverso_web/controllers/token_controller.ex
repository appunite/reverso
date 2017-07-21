defmodule Reverso.Web.TokenController do
  use Reverso.Web, :controller

  alias Reverso.Accounts

  def password_reset(conn, %{"token" => token, "new_password" => new_password}) do
    case Accounts.reset_password(token, new_password) do
      {:ok, _} ->
        conn
        |> send_resp(200, "Password changed!")
      {:error, :user_not_found} ->
        conn
        |> send_resp(401, "User not found!")
    end
  end

  def activate_account(conn, %{"token" => token}) do
    case Accounts.activate(token) do
      {:ok, _} ->
        conn
        |> send_resp(200, "User activated!")
      {:error, :user_not_found} ->
        conn
        |> send_resp(401, "User not found!")
    end
  end
end
