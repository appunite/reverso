defmodule Reverso.Web.AccountController do
  use Reverso.Web, :controller

  alias Reverso.Accounts.User
  alias Reverso.Accounts.Password
  alias Reverso.Accounts.Activation

  def start_password_reset(conn, email_struct) do
    with {:ok, _} <- Password.start_password_reset(email_struct) do
      conn
      |> send_resp(200, "")
    else
      {:error, _} -> 
        conn
        |> send_resp(200, "")
    end
  end

  def password_reset(conn, password_reset_set) do
    with {:ok, _} <- Password.reset_password(password_reset_set) do
      conn
      |> send_resp(200, "")
    else
      {:error, _} ->
        conn
        |> put_status(422)
        |> render("message.json", %{error: "User does not exist!"})
    end
  end

  def activate_account(conn, %{"token" => token}) do
    with {:ok, _} <- Activation.activate(token) do
      conn
      |> redirect(to: "/#/account-activated")
    else
      {:error, :user_not_found} ->
        conn
        |> redirect(to: "/")
    end
  end

  def generate_activation_url(%User{} = user) do
    Reverso.Web.Router.Helpers.account_url(Reverso.Web.Endpoint,
      :activate_account,
      token: user.activation_token)
  end

  def generate_password_reset_url(%User{} = user) do
    Application.get_env(:reverso_web, :reset_password_url) <> "?token=" <> user.password_reset_token
  end
end
