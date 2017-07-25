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
        |> put_status(422)
        |> render("login_message.json", %{error: "Invalid credentials!"})
      {:error, :user_not_activated} ->
        conn
        |> put_status(422)
        |> render("login_message.json", %{error: "User not activated!"})
    end
  end

  def delete(conn, _params) do
    with {:ok, _} <- Accounts.delete_login_token(conn.assigns[:current_user]) do
      send_resp(conn, 200, "Logged out!")
    else
      _ -> send_resp(conn, 404, "User with specified token not found!")
    end

  end

end
