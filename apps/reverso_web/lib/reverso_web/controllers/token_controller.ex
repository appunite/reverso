defmodule Reverso.Web.TokenController do
  use Reverso.Web, :controller

  alias Reverso.Accounts
  alias Reverso.Accounts.User

  def resetpassword(conn, %{"token" => token} = params) do

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
