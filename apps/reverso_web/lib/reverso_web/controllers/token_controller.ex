defmodule Reverso.Web.TokenController do
  use Reverso.Web, :controller

  alias Reverso.Accounts
  alias Reverso.Accounts.User

  def start_password_reset(conn, %{"email" => email}) do
    with {:ok, %User{} = user} <- Accounts.fetch_by_email(email),
         {:ok, %User{} = user} <- Accounts.create_password_token(user),
         {:ok, _} <- Reverso.Email.send_reset_password_email(user) do
      conn
      |> send_resp(200, "")
    else
      {:error, _} -> 
        conn
        |> put_status(422)
        |> render("message.json", %{error: "User does not exist!"})
    end
  end

  def password_reset(conn, %{
        "token" => token,
        "new_password" => new_password,
        "new_password_confirmation" => new_password_confirmation}) do
    with {:ok, _} <- Accounts.reset_password(token, %{
                  password: new_password,
                  password_confirmation: new_password_confirmation})do
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
    with {:ok, _} <- Accounts.activate(token) do
      conn
      |> redirect(to: "/#/account-activated")
    else
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
