defmodule Reverso.Web.SessionController do
  use Reverso.Web, :controller

  alias Reverso.Accounts.Login
  alias Reverso.Accounts.User

  action_fallback Reverso.Web.FallbackController

  def create(conn, %{"params" => session_params}) do
    case Login.login(session_params) do
      {:ok, %User{} = user } ->
        conn
        |> put_status(200)
        |> render("session.json", user: user)
      {:error, :invalid_credentials} ->
        conn
        |> put_status(422)
        |> render("message.json", %{error: "Invalid credentials!"})
      {:error, :user_not_activated} ->
        conn
        |> put_status(422)
        |> render("message.json", %{error: "User not activated!"})
    end
  end

  def delete(conn, _params) do
    with {:ok, _} <- Login.delete_login_token(conn.assigns[:current_user]) do
      send_resp(conn, 200, "")
    else
      _ ->
        conn
        |> put_status(422)
        |> render("message.json", %{error: "User does not exist!"})
    end

  end

end
