defmodule Reverso.Web.TokenController do
  use Reverso.Web, :controller

  alias Reverso.Accounts
  alias Reverso.Accounts.User

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
        |> redirect(to: "/#/account-activated")
      {:error, :user_not_found} ->
        conn
        |> redirect(to: "/")
    end
  end

  def generate_activation_url(%User{} = user) do
    Reverso.Web.Router.Helpers.token_url(Reverso.Web.Endpoint,
      :activate_account,
      token: user.activation_token)
  end

  def generate_password_reset_url(%User{} = user) do
    Application.get_env(:reverso_web, :reset_password_url) <> "?token=" <> user.password_reset_token
  end
end
